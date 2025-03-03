import 'package:flutter/material.dart';

class EmergencySupport extends StatelessWidget {
  const EmergencySupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 4,
        title: const Text(
          'Emergency Support',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
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
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            GestureDetector(
              onDoubleTap: () => _showExpertDetails(context, 'Dr. Sarah Johnson'),
              child: _buildExpertCard(
                'Dr. Sarah Johnson',
                'Clinical Psychologist',
                '15 years experience',
                Colors.blue.shade700,
                context,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onDoubleTap: () => _showExpertDetails(context, 'Dr. Michael Chen'),
              child: _buildExpertCard(
                'Dr. Michael Chen',
                'Psychiatrist',
                '12 years experience',
                Colors.blue.shade700,
                context,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onDoubleTap: () => _showExpertDetails(context, 'Dr. Emily Wilson'),
              child: _buildExpertCard(
                'Dr. Emily Wilson',
                'Counseling Psychologist',
                '10 years experience',
                Colors.blue.shade700,
                context,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExpertDetails(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Contact $name'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Would you like to schedule a consultation with $name?'),
            const SizedBox(height: 10),
            const Text('Available for:'),
            const Text('• Video consultations'),
            const Text('• Voice calls'),
            const Text('• Chat sessions'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Contacting $name'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
            ),
            child: const Text('Contact'),
          ),
        ],
      ),
    );
  }

  Widget _buildExpertCard(
    String name,
    String specialization,
    String experience,
    Color color,
    BuildContext context,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.person,
                color: color,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialization,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    experience,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
