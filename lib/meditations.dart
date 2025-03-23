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

class _MeditationsState extends State<Meditations> {
  // Selected category
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Sleep',
    'Anxiety',
    'Focus',
    'Stress',
    'Beginners'
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
  ];

  YoutubePlayerController? _controller;
  MeditationVideo? _currentVideo;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _playVideo(MeditationVideo video) {
    setState(() {
      _currentVideo = video;
      _controller = YoutubePlayerController(
        initialVideoId: video.videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    });
  }

  void _closeVideo() {
    setState(() {
      _controller?.pause();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.of(context).pop();
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
    return Container(
      color: Colors.black.withOpacity(0.9),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: _closeVideo,
            ),
            title: Text(
              _currentVideo?.title ?? "",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Center(
              child: _controller != null
                  ? YoutubePlayer(
                      controller: _controller!,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.blue,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.blue,
                        handleColor: Colors.blue,
                      ),
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
          if (_currentVideo != null)
            Padding(
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
                  const SizedBox(height: 8),
                  Text(
                    _currentVideo!.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
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
                ],
              ),
            ),
        ],
      ),
    );
  }
}