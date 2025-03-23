import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MeditationVideo {
  final String title;
  final String description;
  final String duration;
  final String category;
  final String videoId;
  final String thumbnailUrl;

  MeditationVideo({
    required this.title,
    required this.description,
    required this.duration,
    required this.category,
    required this.videoId,
    required this.thumbnailUrl,
  });
}

class Meditations extends StatefulWidget {
  const Meditations({super.key});

  @override
  State<Meditations> createState() => _MeditationsState();
}

class _MeditationsState extends State<Meditations> with WidgetsBindingObserver {
  // Selected category
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Sleep',
    'Anxiety',
    'Focus',
    'Stress',
    'Beginners',
    'Motivation',
    'Mindfulness'
  ];

  // List of meditation videos
  final List<MeditationVideo> _meditationVideos = [
    MeditationVideo(
      title: "Calm Waters: 10-Min Anxiety Relief",
      description: "A gentle guide to release anxiety and find inner calm",
      duration: "10 min",
      category: "Anxiety",
      videoId: "O-6f5wQXSu8",
      thumbnailUrl: "https://img.youtube.com/vi/O-6f5wQXSu8/0.jpg",
    ),
    MeditationVideo(
      title: "Starlight Dreams: Sleep Journey",
      description: "Fall asleep faster with this soothing meditation",
      duration: "20 min",
      category: "Sleep",
      videoId: "aEqlQvczMJQ",
      thumbnailUrl: "https://img.youtube.com/vi/aEqlQvczMJQ/0.jpg",
    ),
    MeditationVideo(
      title: "First Light: Morning Mindfulness",
      description: "Start your day with clarity and positive energy",
      duration: "15 min",
      category: "Beginners",
      videoId: "inpok4MKVLM",
      thumbnailUrl: "https://img.youtube.com/vi/inpok4MKVLM/0.jpg",
    ),
    MeditationVideo(
      title: "Laser Mind: Deep Focus Session",
      description: "Sharpen your concentration for work or study",
      duration: "25 min",
      category: "Focus",
      videoId: "1ZYbU82GVz4",
      thumbnailUrl: "https://img.youtube.com/vi/1ZYbU82GVz4/0.jpg",
    ),
    MeditationVideo(
      title: "Tension Melt: Stress Release",
      description: "Release physical and mental tension",
      duration: "18 min",
      category: "Stress",
      videoId: "z6X5oEIg6Ak",
      thumbnailUrl: "https://img.youtube.com/vi/z6X5oEIg6Ak/0.jpg",
    ),
    MeditationVideo(
      title: "Breath & Body: Beginner's Guide",
      description: "Perfect introduction to meditation practice",
      duration: "10 min",
      category: "Beginners",
      videoId: "U9YKY7fdwyg",
      thumbnailUrl: "https://img.youtube.com/vi/U9YKY7fdwyg/0.jpg",
    ),
    MeditationVideo(
      title: "Moonlight Whispers: Deep Sleep",
      description: "Drift into deep, restorative sleep",
      duration: "30 min",
      category: "Sleep",
      videoId: "EiYm20F9WXU",
      thumbnailUrl: "https://img.youtube.com/vi/EiYm20F9WXU/0.jpg",
    ),
    MeditationVideo(
      title: "Clarity Fountain: Anxiety Dissolve",
      description: "Transform anxious thoughts into peaceful clarity",
      duration: "15 min",
      category: "Anxiety",
      videoId: "O8G9ltYzdHM",
      thumbnailUrl: "https://img.youtube.com/vi/O8G9ltYzdHM/0.jpg",
    ),
    MeditationVideo(
      title: "Power Hour: Focused Energy",
      description: "Boost your mental energy and concentration",
      duration: "20 min",
      category: "Focus",
      videoId: "wruCWicGBA4",
      thumbnailUrl: "https://img.youtube.com/vi/wruCWicGBA4/0.jpg",
    ),
    MeditationVideo(
      title: "Serenity Now: Instant Stress Relief",
      description: "Quick stress reduction for busy moments",
      duration: "8 min",
      category: "Stress",
      videoId: "cEqZthCaMpo",
      thumbnailUrl: "https://img.youtube.com/vi/cEqZthCaMpo/0.jpg",
    ),
    // Added new videos
    MeditationVideo(
      title: "Ocean Waves: Deep Sleep Meditation",
      description: "Drift to sleep with calming ocean sounds and guidance",
      duration: "45 min",
      category: "Sleep",
      videoId: "DWcJFNfaw9c",
      thumbnailUrl: "https://img.youtube.com/vi/DWcJFNfaw9c/0.jpg",
    ),
    MeditationVideo(
      title: "Morning Energy Boost",
      description: "Energize your day with this revitalizing meditation",
      duration: "12 min",
      category: "Motivation",
      videoId: "ENYYb5vIMkc",
      thumbnailUrl: "https://img.youtube.com/vi/ENYYb5vIMkc/0.jpg",
    ),
    MeditationVideo(
      title: "Gratitude Practice",
      description: "Cultivate thankfulness and positive energy",
      duration: "15 min",
      category: "Mindfulness",
      videoId: "xfD4HaBBc0I",
      thumbnailUrl: "https://img.youtube.com/vi/xfD4HaBBc0I/0.jpg",
    ),
    MeditationVideo(
      title: "Exam Anxiety Relief",
      description: "Calm your mind before important tests or presentations",
      duration: "20 min",
      category: "Anxiety",
      videoId: "aJCv7K7cfpM",
      thumbnailUrl: "https://img.youtube.com/vi/aJCv7K7cfpM/0.jpg",
    ),
    MeditationVideo(
      title: "Mindful Eating Practice",
      description: "Transform your relationship with food through mindfulness",
      duration: "18 min",
      category: "Mindfulness",
      videoId: "oJo7MTJdgIo",
      thumbnailUrl: "https://img.youtube.com/vi/oJo7MTJdgIo/0.jpg",
    ),
    MeditationVideo(
      title: "Creative Visualization",
      description: "Unlock your creative potential through guided imagery",
      duration: "25 min",
      category: "Motivation",
      videoId: "Ks-_Mh1QhMc",
      thumbnailUrl: "https://img.youtube.com/vi/Ks-_Mh1QhMc/0.jpg",
    ),
    MeditationVideo(
      title: "Workplace Focus Enhancement",
      description: "Improve concentration and productivity at work",
      duration: "15 min",
      category: "Focus",
      videoId: "ZToicYcHIOU",
      thumbnailUrl: "https://img.youtube.com/vi/ZToicYcHIOU/0.jpg",
    ),
    MeditationVideo(
      title: "Evening Wind Down",
      description: "Prepare your mind and body for restful sleep",
      duration: "22 min",
      category: "Sleep",
      videoId: "acUZdGd_3Gk",
      thumbnailUrl: "https://img.youtube.com/vi/acUZdGd_3Gk/0.jpg",
    ),
    MeditationVideo(
      title: "5-Minute Emergency Calm",
      description: "Quick relief for moments of high stress or anxiety",
      duration: "5 min",
      category: "Stress",
      videoId: "sTUNySzof3s",
      thumbnailUrl: "https://img.youtube.com/vi/sTUNySzof3s/0.jpg",
    ),
    MeditationVideo(
      title: "Body Scan for Beginners",
      description: "Learn to release tension through mindful body awareness",
      duration: "15 min",
      category: "Beginners",
      videoId: "QS2yDmWk0vs",
      thumbnailUrl: "https://img.youtube.com/vi/QS2yDmWk0vs/0.jpg",
    ),
  ];

  YoutubePlayerController? _controller;
  MeditationVideo? _currentVideo;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && _controller != null) {
      _controller!.pause();
    }
  }

  void _playVideo(MeditationVideo video) {
    // Clean up any existing controller
    if (_controller != null) {
      _controller!.dispose();
    }
    
    // Create a new controller for this video
    final controller = YoutubePlayerController(
      initialVideoId: video.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        showLiveFullscreenButton: false,
      ),
    );
    
    setState(() {
      _currentVideo = video;
      _controller = controller;
    });
  }

  void _closeVideo() {
    if (_controller != null) {
      _controller!.pause();
      _controller!.dispose();
    }
    
    setState(() {
      _currentVideo = null;
      _controller = null;
    });
  }

  List<MeditationVideo> get _filteredVideos {
    if (_selectedCategory == 'All') {
      return _meditationVideos;
    } else {
      return _meditationVideos
          .where((video) => video.category == _selectedCategory)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentVideo != null) {
          _closeVideo();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 4,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () {
              if (_currentVideo != null) {
                _closeVideo();
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
          title: const Text(
            'Guided Meditations',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  // Categories
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          final isSelected = category == _selectedCategory;
                          
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = category;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.black : Colors.white,
                                  borderRadius: BorderRadius.circular(25.0),
                                  border: Border.all(
                                    color: isSelected ? Colors.blue : Colors.grey.shade300,
                                    width: 2.0,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  // Featured meditation banner
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        image: const DecorationImage(
                          image: NetworkImage('https://img.youtube.com/vi/O8G9ltYzdHM/0.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _playVideo(_meditationVideos[7]); // Play the "Clarity Fountain" video
                          },
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Featured Today',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Clarity Fountain: Anxiety Dissolve',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Video grid
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _filteredVideos.isEmpty
                          ? const Center(
                              child: Text(
                                'No meditations found in this category',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: _filteredVideos.length,
                              itemBuilder: (context, index) {
                                final video = _filteredVideos[index];
                                return _buildVideoCard(video);
                              },
                            ),
                    ),
                  ),
                ],
              ),
              
              // Video player overlay
              if (_currentVideo != null && _controller != null)
                _buildVideoPlayerOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard(MeditationVideo video) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: InkWell(
        onTap: () => _playVideo(video),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Image.network(
                    video.thumbnailUrl,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 100,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        video.duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      video.category,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    video.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    video.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayerOverlay() {
    // Using direct implementation without extra wrappers for more reliable playback
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: _closeVideo,
              ),
              title: Text(
                _currentVideo?.title ?? "",
                style: const TextStyle(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // Direct YouTube player without nested builders
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: YoutubePlayer(
                      controller: _controller!,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.blue,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.blue,
                        handleColor: Colors.blue,
                      ),
                      onReady: () {
                        // Player is ready to play
                        print("YouTube Player Ready");
                      },
                      onEnded: (metaData) {
                        // Video ended - you could navigate back or show related videos
                      },
                    ),
                  ),
                  
                  // Video details
                  if (_currentVideo != null)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _currentVideo!.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _currentVideo!.description,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      _currentVideo!.category,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    _currentVideo!.duration,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              
                              // Playback controls (optional)
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.skip_previous, color: Colors.white, size: 36),
                                    onPressed: () {
                                      // Find previous video in the category and play it
                                      final videos = _filteredVideos;
                                      final currentIndex = videos.indexWhere((v) => v.videoId == _currentVideo!.videoId);
                                      if (currentIndex > 0) {
                                        _playVideo(videos[currentIndex - 1]);
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    icon: const Icon(Icons.replay_10, color: Colors.white, size: 36),
                                    onPressed: () {
                                      // Rewind 10 seconds
                                      if (_controller != null) {
                                        final currentPosition = _controller!.value.position.inSeconds;
                                        _controller!.seekTo(Duration(seconds: currentPosition - 10));
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    icon: Icon(
                                      _controller?.value.isPlaying ?? false 
                                          ? Icons.pause_circle_filled 
                                          : Icons.play_circle_filled,
                                      color: Colors.white,
                                      size: 48,
                                    ),
                                    onPressed: () {
                                      if (_controller != null) {
                                        if (_controller!.value.isPlaying) {
                                          _controller!.pause();
                                        } else {
                                          _controller!.play();
                                        }
                                        setState(() {});
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    icon: const Icon(Icons.forward_10, color: Colors.white, size: 36),
                                    onPressed: () {
                                      // Forward 10 seconds
                                      if (_controller != null) {
                                        final currentPosition = _controller!.value.position.inSeconds;
                                        _controller!.seekTo(Duration(seconds: currentPosition + 10));
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    icon: const Icon(Icons.skip_next, color: Colors.white, size: 36),
                                    onPressed: () {
                                      // Find next video in the category and play it
                                      final videos = _filteredVideos;
                                      final currentIndex = videos.indexWhere((v) => v.videoId == _currentVideo!.videoId);
                                      if (currentIndex < videos.length - 1) {
                                        _playVideo(videos[currentIndex + 1]);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}