import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class RelaxingSoundsPage extends StatefulWidget {
  const RelaxingSoundsPage({Key? key}) : super(key: key);

  @override
  _RelaxingSoundsPageState createState() => _RelaxingSoundsPageState();
}

class _RelaxingSoundsPageState extends State<RelaxingSoundsPage> {
  // Audio players for each sound
  final AudioPlayer _rainPlayer = AudioPlayer();
  final AudioPlayer _oceanPlayer = AudioPlayer();
  final AudioPlayer _forestPlayer = AudioPlayer();
  final AudioPlayer _fireplacPlayer = AudioPlayer();

  // Volume controllers
  double _rainVolume = 0.5;
  double _oceanVolume = 0.5;
  double _forestVolume = 0.5;
  double _fireplaceVolume = 0.5;

  // Sound sources (adjust paths as needed)
  final List<Map<String, dynamic>> _sounds = [
    {
      'name': 'Rain',
      'asset': 'rain.mp3',
      'icon': Icons.water_drop,
      'color': Colors.blue
    },
    {
      'name': 'Ocean',
      'asset': 'ocean.mp3',
      'icon': Icons.waves,
      'color': Colors.teal
    },
    {
      'name': 'Forest',
      'asset': 'forest.mp3',
      'icon': Icons.forest,
      'color': Colors.green
    },
    {
      'name': 'Fireplace',
      'asset': 'fireplace.mp3',
      'icon': Icons.local_fire_department,
      'color': Colors.orange
    },
  ];

  @override
  void dispose() {
    // Ensure all players are released
    _rainPlayer.dispose();
    _oceanPlayer.dispose();
    _forestPlayer.dispose();
    _fireplacPlayer.dispose();
    super.dispose();
  }

  Future<void> _toggleSound(AudioPlayer player, String asset, double volume) async {
    PlayerState? currentState = player.state;

    if (currentState == PlayerState.playing) {
      await player.pause();
    } else {
      // Use source from asset
      await player.play(AssetSource(asset));
      
      // Set loop mode
      await player.setReleaseMode(ReleaseMode.loop);
      
      // Set volume
      await player.setVolume(volume);
    }

    // Force UI update
    setState(() {});
  }

  Widget _buildSoundControl(Map<String, dynamic> sound, AudioPlayer player, double volume, ValueChanged<double> onVolumeChanged) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: sound['color'].withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  sound['icon'],
                  color: sound['color'],
                  size: 30,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                sound['name'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  player.state == PlayerState.playing 
                    ? Icons.pause_circle 
                    : Icons.play_circle,
                  color: sound['color'],
                  size: 40,
                ),
                onPressed: () => _toggleSound(player, sound['asset'], volume),
              ),
            ],
          ),
          Slider(
            value: volume,
            min: 0.0,
            max: 1.0,
            activeColor: sound['color'],
            onChanged: onVolumeChanged,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relaxing Sounds'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose Your Relaxing Sound',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Rain Sound
                _buildSoundControl(
                  _sounds[0], 
                  _rainPlayer, 
                  _rainVolume, 
                  (value) async {
                    setState(() => _rainVolume = value);
                    await _rainPlayer.setVolume(value);
                  }
                ),
                
                // Ocean Sound
                _buildSoundControl(
                  _sounds[1], 
                  _oceanPlayer, 
                  _oceanVolume, 
                  (value) async {
                    setState(() => _oceanVolume = value);
                    await _oceanPlayer.setVolume(value);
                  }
                ),
                
                // Forest Sound
                _buildSoundControl(
                  _sounds[2], 
                  _forestPlayer, 
                  _forestVolume, 
                  (value) async {
                    setState(() => _forestVolume = value);
                    await _forestPlayer.setVolume(value);
                  }
                ),
                
                // Fireplace Sound
                _buildSoundControl(
                  _sounds[3], 
                  _fireplacPlayer, 
                  _fireplaceVolume, 
                  (value) async {
                    setState(() => _fireplaceVolume = value);
                    await _fireplacPlayer.setVolume(value);
                  }
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
