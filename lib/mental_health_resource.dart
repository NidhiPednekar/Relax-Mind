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
      title: "Digital Detox",
      description: "Set boundaries with technology. Allocate specific times for social media and screen time. Create tech-free zones in your home to reduce mental clutter.",
      imagePath: "images/digital_detox.jpg",
      category: "Well-being",
    ),
    MentalHealthTip(
      title: "Gratitude Journaling",
      description: "Write down three things you're grateful for each day. This practice shifts focus to positive aspects of life and improves overall mental outlook.",
      imagePath: "images/gratitude_journal.jpg",
      category: "Positive Psychology",
    ),
    MentalHealthTip(
    title: "Mindful Breathing",
    description: "Take a few deep breaths, focusing on each inhale and exhale. This simple practice helps reduce stress and increase mindfulness.",
    imagePath: "images/mindful_breathing.jpg",
    category: "Mindfulness",
  ),

    MentalHealthTip(
    title: "Daily Exercise",
    description: "Engage in at least 30 minutes of physical activity to boost mood, reduce stress, and improve overall well-being.",
    imagePath: "images/daily_exercise.jpeg",
    category: "Physical Well-being",
  ),


    MentalHealthTip(
    title: "Sleep Hygiene",
    description: "Maintain a consistent sleep schedule and create a calming bedtime routine to enhance sleep quality and overall mental health.",
    imagePath: "images/sleep_hygiene.jpeg",
    category: "Self-Care",
  ),

    MentalHealthTip(
    title: "Connecting with Nature",
    description: "Spend time outdoors, whether in a park or garden, to reduce stress and boost mental clarity.",
    imagePath: "images/nature_walk.jpg",
    category: "Well-being",
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
    VideoInfo(
    title: "Guided Sleep Meditation",
    videoId: "6p_yaNFSYao",
    duration: "20 min",
    category: "Relaxation",
  ),

    VideoInfo(
    title: "Deep Breathing Exercises",
    videoId: "nac4S2kXxA4",
    duration: "10 min",
    category: "Stress Relief",
  ),

    VideoInfo(
    title: "Positive Affirmations for Mental Clarity",
    videoId: "aEzl6E92sHY",
    duration: "12 min",
    category: "Self-Growth",
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