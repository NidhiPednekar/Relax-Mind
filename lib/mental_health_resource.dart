import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


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
      description: "In our hyper-connected world, constant digital stimulation can lead to mental fatigue and stress. Practice a digital detox by setting clear boundaries with technology. Create specific time blocks for checking social media and emails, and establish tech-free zones in your home. Consider turning off notifications during work or personal time. Use this reclaimed time for mindful activities like reading, meditation, or face-to-face interactions. This practice helps reduce anxiety, improves focus, and allows your mind to reset and recharge.",
      imagePath: "images/digital_detox.jpg",
      category: "Well-being",
      detailedTips: [
        "Set daily screen time limits",
        "Create a no-phone zone in your bedroom",
        "Practice mindful technology use",
        "Engage in offline activities daily"
      ]
    ),
    MentalHealthTip(
      title: "Gratitude Journaling",
      description: "Gratitude is a powerful mental health tool that shifts your focus from what's wrong to what's right in your life. By consistently documenting things you're thankful for, you rewire your brain to recognize positive experiences. This practice isn't about ignoring challenges, but about building resilience and emotional balance. Regularly reflecting on gratitude can reduce stress, improve sleep, and increase overall life satisfaction. It helps combat negative thought patterns and promotes a more optimistic outlook.",
      imagePath: "images/gratitude_journal.jpg",
      category: "Positive Psychology",
      detailedTips: [
        "Write 3 things you're grateful for daily",
        "Be specific in your gratitude entries",
        "Include small and big moments",
        "Reflect on personal growth and lessons"
      ]
    ),
    MentalHealthTip(
      title: "Mindful Breathing",
      description: "Mindful breathing is a simple yet profound technique to manage stress and enhance emotional regulation. By consciously focusing on your breath, you activate the body's relaxation response, reducing cortisol levels and calming the nervous system. This practice helps interrupt racing thoughts, increases present-moment awareness, and provides an immediate tool for emotional self-regulation. Regular mindful breathing can improve concentration, reduce anxiety, and create a sense of inner peace.",
      imagePath: "images/mindful_breathing.jpg",
      category: "Mindfulness",
      detailedTips: [
        "Practice 4-7-8 breathing technique",
        "Set aside 5-10 minutes daily",
        "Use breathing as a stress management tool",
        "Combine with meditation for deeper relaxation"
      ]
    ),
    MentalHealthTip(
  title: "Progressive Muscle Relaxation",
  description: "Progressive Muscle Relaxation (PMR) is a technique that helps reduce stress and anxiety by systematically tensing and relaxing different muscle groups. This method promotes physical relaxation, improves sleep quality, and enhances overall mental well-being. Practicing PMR regularly can help you become more aware of physical tension and effectively release it.",
  imagePath: "images/pmr.jpg",
  category: "Stress Relief",
  detailedTips: [
    "Start from your toes and work upward",
    "Tense each muscle group for 5-10 seconds, then relax",
    "Breathe deeply while practicing",
    "Practice daily for best results"
  ]
),

MentalHealthTip(
  title: "Setting Healthy Boundaries",
  description: "Establishing personal boundaries is essential for mental well-being. Healthy boundaries protect your energy, prevent burnout, and improve relationships by fostering mutual respect. Learning to say no, prioritizing self-care, and communicating limits clearly can help maintain emotional balance and reduce stress.",
  imagePath: "images/boundaries.png",
  category: "Emotional Well-being",
  detailedTips: [
    "Recognize your personal limits",
    "Communicate boundaries assertively",
    "Learn to say no without guilt",
    "Prioritize self-care without overcommitting"
  ]
),

    MentalHealthTip(
      title: "Daily Exercise",
      description: "Physical activity is a powerful mental health intervention. Regular exercise releases endorphins, the body's natural mood elevators, which combat depression and anxiety. Beyond physiological benefits, exercise provides a sense of achievement, improves self-esteem, and offers opportunities for social interaction. Whether it's a brisk walk, yoga, dancing, or strength training, finding an enjoyable physical activity can significantly enhance mental well-being and provide a healthy coping mechanism for stress.",
      imagePath: "images/daily_exercise.jpeg",
      category: "Physical Well-being",
      detailedTips: [
        "Choose activities you enjoy",
        "Start with 30 minutes daily",
        "Mix cardio and strength training",
        "Set realistic and progressive goals"
      ]
    ),
    MentalHealthTip(
      title: "Sleep Hygiene",
      description: "Quality sleep is fundamental to mental health. Poor sleep can exacerbate anxiety, depression, and cognitive difficulties. Developing a consistent sleep routine helps regulate your body's internal clock, improve mood stability, and enhance cognitive function. A holistic approach to sleep hygiene involves creating a conducive sleep environment, managing screen time, practicing relaxation techniques, and maintaining a consistent sleep schedule. Prioritizing sleep is an essential form of self-care and mental health maintenance.",
      imagePath: "images/sleep_hygiene.jpeg",
      category: "Self-Care",
      detailedTips: [
        "Maintain consistent sleep and wake times",
        "Create a calming bedtime ritual",
        "Limit caffeine and screen time before bed",
        "Keep bedroom cool and dark"
      ]
    ),
    MentalHealthTip(
      title: "Connecting with Nature",
      description: "Nature has inherent healing properties that can significantly improve mental health. Spending time outdoors reduces stress hormones, lowers blood pressure, and increases feelings of calm and happiness. Natural environments provide sensory stimulation that helps reset our overstimulated minds. Whether it's a forest walk, gardening, or simply sitting in a park, connecting with nature offers a powerful antidote to urban stress, promotes mindfulness, and enhances overall psychological well-being.",
      imagePath: "images/nature_walk.jpg",
      category: "Well-being",
      detailedTips: [
        "Take daily outdoor breaks",
        "Practice walking meditation in nature",
        "Engage in outdoor physical activities",
        "Create a small indoor or balcony garden"
      ]
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
      videoId: "F28MGLlpP90",
      duration: "10 min",
      category: "Stress Relief",
    ),
    VideoInfo(
      title: "Positive Affirmations for Mental Clarity",
      videoId: "kGgcgEPeiYE",
      duration: "12 min",
      category: "Self-Growth",
    ),
    VideoInfo(
  title: "Stress Relief Yoga Flow",
  videoId: "7CTsdbf81W8",
  duration: "25 min",
  category: "Relaxation",
),
VideoInfo(
  title: "Body Scan Meditation",
  videoId: "uqtIqCKjkuc",
  duration: "20 min", 
  category: "Mindfulness",
),
VideoInfo(
  title: "Anxiety Reduction Techniques",
  videoId: "xGb4fvfZpWM",
  duration: "18 min",
  category: "Mental Health",
),
VideoInfo(
  title: "Evening Wind Down Meditation",
  videoId: "_3fvhTO3pLM",
  duration: "15 min",
  category: "Sleep Preparation",
),
    
  ];

Future<void> _launchYouTubeVideo(VideoInfo video) async {
    final Uri url = Uri.parse('https://www.youtube.com/watch?v=${video.videoId}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch ${video.title} video')),
      );
    }
  }

  void _showTipDetailDialog(MentalHealthTip tip) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tip.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 16),
              const Text(
                'Actionable Tips:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...tip.detailedTips.map((actionTip) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• '),
                        Expanded(child: Text(actionTip)),
                      ],
                    ),
                  )),
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
                  trailing: const Icon(Icons.play_circle_outline),
                  onTap: () => _launchYouTubeVideo(video),
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
}

class MentalHealthTip {
  final String title;
  final String description;
  final String imagePath;
  final String category;
  final List<String> detailedTips;

  MentalHealthTip({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.category,
    required this.detailedTips,
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