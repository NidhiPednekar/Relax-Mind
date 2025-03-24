import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PeacefulMusic extends StatefulWidget {
  const PeacefulMusic({super.key});

  @override
  State<PeacefulMusic> createState() => _PeacefulMusicState();
}

class _PeacefulMusicState extends State<PeacefulMusic> with WidgetsBindingObserver {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isLoading = false;
  double _currentPosition = 0;
  double _totalDuration = 0;
  int _selectedMusicIndex = -1;

  final List<Map<String, dynamic>> _musicList = [
    {
      'title': 'Gentle Rain',
      'description': 'Soft rainfall for deep relaxation',
      'url': 'https://cdn.pixabay.com/download/audio/2022/03/10/audio_9ccca15d4a.mp3',
      'icon': Icons.water_drop,
      'color': Colors.blue,
    },
    {
      'title': 'Calm Meditation',
      'description': 'Peaceful ambient music for meditation',
      'url': 'https://cdn.pixabay.com/download/audio/2022/01/18/audio_d0c6ff1bab.mp3',
      'icon': Icons.self_improvement,
      'color': Colors.purple,
    },
    {
      'title': 'Ocean Waves',
      'description': 'Gentle waves washing ashore',
      'url': 'https://cdn.pixabay.com/download/audio/2021/09/06/audio_fd83e87433.mp3',
      'icon': Icons.waves,
      'color': Colors.cyan,
    },
    {
      'title': 'Soft Piano',
      'description': 'Delicate piano melodies for relaxation',
      'url': 'https://cdn.pixabay.com/download/audio/2022/01/20/audio_d16737d443.mp3',
      'icon': Icons.piano,
      'color': Colors.indigo,
    },
    {
      'title': 'Tibetan Bowls',
      'description': 'Healing sounds of singing bowls',
      'url': 'https://cdn.pixabay.com/download/audio/2022/03/15/audio_c8b8c567e5.mp3',
      'icon': Icons.surround_sound,
      'color': Colors.amber,
    },
    {
      'title': 'Forest Birds',
      'description': 'Peaceful birdsong in a quiet forest',
      'url': 'https://cdn.pixabay.com/download/audio/2021/04/08/audio_b4115c021e.mp3',
      'icon': Icons.forest,
      'color': Colors.green,
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupAudioPlayer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is in background, pause audio
      _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    }
  }

  void _setupAudioPlayer() {
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
          _currentPosition = 0;
        });
      }
    });

    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _currentPosition = position.inMilliseconds.toDouble();
      });
    });

    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        setState(() {
          _totalDuration = duration.inMilliseconds.toDouble();
        });
      }
    });
  }

  Future<void> _playMusic(int index) async {
    try {
      setState(() {
        _isLoading = true;
      });

      if (_selectedMusicIndex == index && _isPlaying) {
        await _audioPlayer.pause();
        setState(() {
          _isPlaying = false;
          _isLoading = false;
        });
        return;
      }

      if (_selectedMusicIndex != index) {
        await _audioPlayer.stop();
        
        setState(() {
          _selectedMusicIndex = index;
          _currentPosition = 0;
        });
        
        await _audioPlayer.setUrl(_musicList[index]['url']);
      }

      await _audioPlayer.play();
      
      setState(() {
        _isPlaying = true;
        _isLoading = false;
      });
      
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Now playing: ${_musicList[index]['title']}'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error playing audio: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      
      print('Error playing audio: $e');
    }
  }

  Future<void> _stopMusic() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
        _currentPosition = 0;
        _selectedMusicIndex = -1;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Music stopped'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  void dispose() {
    _stopMusic();
    _audioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  String _formatDuration(double milliseconds) {
    var duration = Duration(milliseconds: milliseconds.round());
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _stopMusic();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Peaceful Music',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.blue),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.music_note,
                      size: 80,
                      color: Colors.black,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Peaceful Music',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Soothing sounds to calm your mind and help you relax. Choose from our collection of peaceful melodies.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              // Stop button - clearly visible when music is playing
              if (_isPlaying)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: ElevatedButton.icon(
                    onPressed: _stopMusic,
                    icon: const Icon(Icons.stop_circle, color: Colors.white),
                    label: const Text(
                      'Stop Music',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _musicList.length,
                  itemBuilder: (context, index) {
                    final music = _musicList[index];
                    final isSelected = _selectedMusicIndex == index;
                    
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: isSelected
                            ? BorderSide(color: music['color'], width: 2)
                            : BorderSide.none,
                      ),
                      child: InkWell(
                        onTap: _isLoading ? null : () => _playMusic(index),
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: music['color'],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      music['icon'],
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          music['title'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          music['description'],
                                          style: TextStyle(
                                            color: Colors.grey[300],
                                            fontSize: 14,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (_isLoading && _selectedMusicIndex == index)
                                    const SizedBox(
                                      width: 36,
                                      height: 36,
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  else
                                    IconButton(
                                      icon: Icon(
                                        isSelected && _isPlaying
                                            ? Icons.pause_circle_filled
                                            : Icons.play_circle_filled,
                                        color: music['color'],
                                        size: 36,
                                      ),
                                      onPressed: _isLoading ? null : () => _playMusic(index),
                                    ),
                                ],
                              ),
                              if (isSelected) ...[
                                const SizedBox(height: 16),
                                SliderTheme(
                                  data: SliderThemeData(
                                    activeTrackColor: music['color'],
                                    inactiveTrackColor: Colors.grey[700],
                                    thumbColor: Colors.white,
                                    trackHeight: 4,
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 6,
                                    ),
                                  ),
                                  child: Slider(
                                    min: 0,
                                    max: _totalDuration > 0 ? _totalDuration : 1,
                                    value: _currentPosition.clamp(
                                        0, _totalDuration > 0 ? _totalDuration : 1),
                                    onChanged: (value) {
                                      setState(() {
                                        _currentPosition = value;
                                      });
                                      _audioPlayer.seek(
                                          Duration(milliseconds: value.round()));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatDuration(_currentPosition),
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        _formatDuration(_totalDuration),
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: _isPlaying ? FloatingActionButton(
          onPressed: _stopMusic,
          backgroundColor: Colors.red,
          child: const Icon(Icons.stop),
          tooltip: 'Stop playing',
        ) : null,
      ),
    );
  }
}
