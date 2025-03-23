import 'package:flutter/material.dart';

class AgeSpecificActivities extends StatelessWidget {
  const AgeSpecificActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age-Specific Activities'),
        backgroundColor: Colors.black,
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Age Group',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildAgeGroupCard(
                      context,
                      'Children (5-12)',
                      'Fun activities to develop emotional awareness',
                      Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    _buildAgeGroupCard(
                      context,
                      'Teenagers (13-19)',
                      'Exercises to manage stress and anxiety',
                      Colors.green,
                    ),
                    const SizedBox(height: 16),
                    _buildAgeGroupCard(
                      context,
                      'Young Adults (20-35)',
                      'Mindfulness practices for work-life balance',
                      Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    _buildAgeGroupCard(
                      context,
                      'Adults (36-60)',
                      'Techniques for stress reduction and mental clarity',
                      Colors.purple,
                    ),
                    const SizedBox(height: 16),
                    _buildAgeGroupCard(
                      context,
                      'Seniors (60+)',
                      'Gentle exercises for mental well-being',
                      Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgeGroupCard(
    BuildContext context,
    String title,
    String description,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.black,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title activities coming soon!'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.psychology,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
