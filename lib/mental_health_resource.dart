import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MentalHealthResource extends StatefulWidget {
  final String title;

  const MentalHealthResource({
    Key? key, 
    required this.title,
  }) : super(key: key);

  @override
  _MentalHealthResourceState createState() => _MentalHealthResourceState();
}

class _MentalHealthResourceState extends State<MentalHealthResource> {
  final List<MentalHealthTip> _tips = [
    MentalHealthTip(
      title: "Mindful Breathing",
      description: "Practice the 4-7-8 breathing technique: Inhale for 4 seconds, hold for 7 seconds, exhale for 8 seconds. This helps reduce anxiety and promotes relaxation.",
      imagePath: "assets/breathing_technique.png",
      category: "Stress Management",
    ),
    MentalHealthTip(
      title: "Digital Detox",
      description: "Set boundaries with technology. Allocate specific times for social media and screen time. Create tech-free zones in your home to reduce mental clutter.",
      imagePath: "assets/digital_detox.png",
      category: "Well-being",
    ),
    MentalHealthTip(
      title: "Gratitude Journaling",
      description: "Write down three things you're grateful for each day. This practice shifts focus to positive aspects of life and improves overall mental outlook.",
      imagePath: "assets/gratitude_journal.png",
      category: "Positive Psychology",
    ),
  ];

  final List<VideoInfo> _videos = [
    VideoInfo(
      title: "Calm Meditation",
      videoId: "O-6f5wQXSu8",
      duration: "10 min",
      category: "Anxiety",
    ),
    VideoInfo(
      title: "Deep Sleep Journey",
      videoId: "aEqlQvczMJQ",
      duration: "20 min", 
      category: "Sleep",
    ),
    VideoInfo(
      title: "Morning Mindfulness",
      videoId: "inpok4MKVLM",
      duration: "15 min",
      category: "Beginners",
    ),
  ];

  YoutubePlayerController? _currentController;

  void _playVideo(VideoInfo video) {
    // Stop current video if playing
    _currentController?.pause();
    _currentController?.dispose();

    // Create new controller
    final newController = YoutubePlayerController(
      initialVideoId: video.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    setState(() {
      _currentController = newController;
    });

    // Show video player dialog
    showDialog(
      context: context,
      builder: (context) => VideoPlayerDialog(
        controller: newController,
        video: video,
      ),
    ).then((_) {
      // When dialog is closed
      newController.pause();
      newController.dispose();
      setState(() {
        _currentController = null;
      });
    });
  }

  @override
  void dispose() {
    _currentController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.video_library), text: 'Meditations'),
              Tab(icon: Icon(Icons.psychology), text: 'Mental Health Tips'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Meditation Videos Tab
            ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                final video = _videos[index];
                return ListTile(
                  title: Text(video.title),
                  subtitle: Text('${video.duration} - ${video.category}'),
                  onTap: () => _playVideo(video),
                );
              },
            ),
            // Mental Health Tips Tab
            ListView.builder(
              itemCount: _tips.length,
              itemBuilder: (context, index) {
                final tip = _tips[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(
                      tip.imagePath,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(tip.title),
                    subtitle: Text(tip.category),
                    onTap: () => _showTipDetailDialog(tip),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTipDetailDialog(MentalHealthTip tip) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tip.title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                tip.imagePath,
                width: 250,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                tip.description,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class MentalHealthTip {
  final String title;
  final String description;
  final String imagePath;
  final String category;

  MentalHealthTip({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.category,
  });
}

class VideoInfo {
  final String title;
  final String videoId;
  final String duration;
  final String category;

  VideoInfo({
    required this.title,
    required this.videoId,
    required this.duration,
    required this.category,
  });
}

class VideoPlayerDialog extends StatelessWidget {
  final YoutubePlayerController controller;
  final VideoInfo video;

  const VideoPlayerDialog({
    Key? key,
    required this.controller,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blue,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  video.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Duration: ${video.duration}'),
                    Text('Category: ${video.category}'),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}