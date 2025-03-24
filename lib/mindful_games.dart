import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:collection/collection.dart';

class MindfulnessGamesScreen extends StatelessWidget {
  const MindfulnessGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BreathingExerciseScreen(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MemoryMatchScreen(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FocusTimerScreen(),
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
}

// Breathing Exercise Game
class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  State<BreathingExerciseScreen> createState() => _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _breathingPhase = "Tap to Start";
  bool _isRunning = false;
  int _seconds = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    if (_isRunning) {
      _timer.cancel();
    }
    super.dispose();
  }

  void _startBreathing() {
    setState(() {
      _isRunning = true;
      _seconds = 0;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        if (_seconds <= 4) {
          _breathingPhase = "Breathe In";
          _controller.value = _seconds / 4;
        } else if (_seconds <= 8) {
          _breathingPhase = "Hold";
          _controller.value = 1.0;
        } else if (_seconds <= 12) {
          _breathingPhase = "Breathe Out";
          _controller.value = (12 - _seconds) / 4;
        } else {
          _seconds = 0;
        }
      });
    });
  }

  void _stopBreathing() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
      _breathingPhase = "Tap to Start";
      _controller.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Exercise'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _breathingPhase,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  if (_isRunning) {
                    _stopBreathing();
                  } else {
                    _startBreathing();
                  }
                },
                child: Container(
                  width: 200 + (_controller.value * 100),
                  height: 200 + (_controller.value * 100),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3 + (_controller.value * 0.4)),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 180 + (_controller.value * 80),
                      height: 180 + (_controller.value * 80),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.5 + (_controller.value * 0.3)),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.air,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                _isRunning ? "Tap the circle to stop" : "Tap the circle to start",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Deep breathing helps reduce stress and anxiety. Try to focus only on your breath.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Memory Match Game
class MemoryMatchScreen extends StatefulWidget {
  const MemoryMatchScreen({super.key});

  @override
  State<MemoryMatchScreen> createState() => _MemoryMatchScreenState();
}

class _MemoryMatchScreenState extends State<MemoryMatchScreen> {
  final List<String> _icons = [
    '😊', '🌟', '🍎', '🌈', '🦋', '🐢', '🌺', '🎵',
    '😊', '🌟', '🍎', '🌈', '🦋', '🐢', '🌺', '🎵',
  ];
  List<bool> _flipped = List.filled(16, false);
  List<bool> _matched = List.filled(16, false);
  int? _previousIndex;
  bool _isProcessing = false;
  int _moves = 0;
  int _matches = 0;

  @override
  void initState() {
    super.initState();
    _icons.shuffle();
  }

  void _resetGame() {
    setState(() {
      _icons.shuffle();
      _flipped = List.filled(16, false);
      _matched = List.filled(16, false);
      _previousIndex = null;
      _isProcessing = false;
      _moves = 0;
      _matches = 0;
    });
  }

  void _onCardTap(int index) {
    if (_isProcessing || _flipped[index] || _matched[index]) return;

    setState(() {
      _flipped[index] = true;

      if (_previousIndex == null) {
        _previousIndex = index;
      } else {
        _moves++;
        _isProcessing = true;

        if (_icons[_previousIndex!] == _icons[index]) {
          // Matched
          _matched[_previousIndex!] = true;
          _matched[index] = true;
          _previousIndex = null;
          _isProcessing = false;
          _matches++;

          if (_matches == 8) {
            // Game completed
            _showCompletionDialog();
          }
        } else {
          // Not matched
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
              _flipped[_previousIndex!] = false;
              _flipped[index] = false;
              _previousIndex = null;
              _isProcessing = false;
            });
          });
        }
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: Text('You completed the game in $_moves moves!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade200, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Moves: $_moves',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Matches: $_matches/8',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 16,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onCardTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _matched[index]
                              ? Colors.green.shade300
                              : _flipped[index]
                                  ? Colors.white
                                  : Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: const Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Center(
                          child: _flipped[index] || _matched[index]
                              ? Text(
                                  _icons[index],
                                  style: const TextStyle(fontSize: 30),
                                )
                              : const Icon(
                                  Icons.question_mark,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _resetGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Reset Game',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Focus Timer Screen
class FocusTimerScreen extends StatefulWidget {
  const FocusTimerScreen({super.key});

  @override
  State<FocusTimerScreen> createState() => _FocusTimerScreenState();
}

class _FocusTimerScreenState extends State<FocusTimerScreen> {
  bool _isRunning = false;
  int _selectedMinutes = 5;
  int _remainingSeconds = 0;
  Timer? _timer;
  final List<int> _timerOptions = [1, 5, 10, 15, 20, 25, 30];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _remainingSeconds = _selectedMinutes * 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _isRunning = false;
          _timer?.cancel();
          _showCompletionDialog();
        }
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _remainingSeconds = _selectedMinutes * 60;
    });
    _timer?.cancel();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Time\'s Up!'),
          content: Text('You completed $_selectedMinutes minutes of focused time!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Great!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _formatTime() {
    final minutes = (_remainingSeconds / 60).floor();
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Timer'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Mindful Focus Timer',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Set a timer to focus on a single task. Stay present and mindful during this time.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _isRunning ? _formatTime() : '$_selectedMinutes:00',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            if (!_isRunning)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Minutes: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _timerOptions.map((minutes) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: ChoiceChip(
                                label: Text('$minutes'),
                                selected: _selectedMinutes == minutes,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() {
                                      _selectedMinutes = minutes;
                                      _remainingSeconds = minutes * 60;
                                    });
                                  }
                                },
                                backgroundColor: Colors.white,
                                selectedColor: Colors.purple,
                                labelStyle: TextStyle(
                                  color: _selectedMinutes == minutes
                                      ? Colors.white
                                      : Colors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRunning ? Colors.orange : Colors.purple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    _isRunning ? 'Pause' : 'Start',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
