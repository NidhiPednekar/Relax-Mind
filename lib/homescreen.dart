import 'package:flutter/material.dart';
import 'support.dart';
import 'profile.dart';
import 'age_activities.dart';
import 'meditations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.blue),
          onPressed: () {
            _showDrawer(context);
          },
        ),
        title: const Text(
          'RelaxMind',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.blue),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Favorites coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _getBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeContent(context);
      case 1:
        return _buildGamesSection(context);
      case 2:
        return const ProfileScreen();
      default:
        return _buildHomeContent(context);
    }
  }

  Widget _buildHomeContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade300, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.self_improvement,
                size: 80,
                color: Colors.black,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to RelaxMind 🌿',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Your personal space for mindfulness, reflection, and emotional well-being. Discover peace through meditation and journaling.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Feature Cards
              _buildFeatureCard(
                context,
                'Guided Meditations',
                'Find your inner peace',
                Icons.self_improvement,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Meditations(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildFeatureCard(
                context,
                'Daily Journal',
                'Track your journey',
                Icons.book,
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Journal coming soon!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildFeatureCard(
                context,
                'Age-Specific Activities',
                'Personalized wellbeing exercises',
                Icons.psychology,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AgeSpecificActivities(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildFeatureCard(
                context,
                'Emergency Support',
                '24/7 assistance',
                Icons.support_agent,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmergencySupport(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGamesSection(BuildContext context) {
    return Container(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.games,
              size: 80,
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            const Text(
              'Mindfulness Games',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Games designed to help improve focus, reduce stress, and promote relaxation.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
           
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildGameCard(
                    context,
                    'Breathing Exercise',
                    Icons.air,
                    Colors.green,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Breathing exercise coming soon!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  _buildGameCard(
                    context,
                    'Memory Match',
                    Icons.flip,
                    Colors.orange,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Memory match game coming soon!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  _buildGameCard(
                    context,
                    'Focus Timer',
                    Icons.timer,
                    Colors.purple,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Focus timer coming soon!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  _buildGameCard(
                    context,
                    'Calming Puzzle',
                    Icons.extension,
                    Colors.blue,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Puzzle game coming soon!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      color: Colors.black,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400, // Increased height to accommodate the new option
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.blue),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.games, color: Colors.blue),
                title: const Text('Games'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.self_improvement, color: Colors.blue),
                title: const Text('Meditations'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Meditations(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.psychology, color: Colors.blue),
                title: const Text('Age Activities'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AgeSpecificActivities(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.support_agent, color: Colors.blue),
                title: const Text('Support'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmergencySupport(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.blue),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Settings coming soon!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.blue),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      color: Colors.black,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
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
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 14,
                      ),
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
}
