import 'package:flutter/material.dart';
import 'happy_moments_screen.dart';
import 'mindful_games.dart';

class MoodCheckScreen extends StatelessWidget {
  const MoodCheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'How are you feeling today?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Select your current mood:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // Happy Mood
              _buildMoodCard(
                context,
                'Happy',
                Icons.sentiment_very_satisfied,
                Colors.amber,
                'I feel positive and content',
              ),
              
              const SizedBox(height: 20),
              
              // Sad Mood
              _buildMoodCard(
                context,
                'Sad',
                Icons.sentiment_dissatisfied,
                Colors.blue,
                'I feel down or unhappy',
              ),
              
              const SizedBox(height: 20),
              
              // Anxious Mood
              _buildMoodCard(
                context,
                'Anxious',
                Icons.sentiment_neutral,
                Colors.purple,
                'I feel worried or nervous',
              ),
              
              const SizedBox(height: 20),
              
              // Angry Mood
              _buildMoodCard(
                context,
                'Angry',
                Icons.sentiment_very_dissatisfied,
                Colors.red,
                'I feel frustrated or upset',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodCard(
    BuildContext context,
    String mood,
    IconData icon,
    Color color,
    String description,
  ) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          _handleMoodSelection(context, mood);
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mood,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMoodSelection(BuildContext context, String mood) {
    // Show a dialog to confirm the mood selection
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You selected: $mood'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('What would you like to do next?'),
              const SizedBox(height: 10),
              if (mood != 'Happy')
                Text(
                  'Since you\'re feeling $mood, we have some suggestions that might help.',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Go Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            if (mood != 'Happy')
              TextButton(
                child: const Text('View Happy Moments'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HappyMomentsScreen(
                        fromMoodCheck: true,
                        currentMood: mood,
                      ),
                    ),
                  );
                },
              ),
            TextButton(
              child: const Text('Play Games'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MindfulnessGamesScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
