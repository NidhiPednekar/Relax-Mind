import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:collection/collection.dart';

class MindfulnessGamesScreen extends StatelessWidget {
  const MindfulnessGamesScreen({super.key});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text('Mindfulness Games'),
      backgroundColor: Colors.blue,
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
                  _buildGameCard(
                    context,
                    'Word Guess',
                    Icons.color_lens,
                    Colors.deepPurple,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WordGuessGameScreen(),
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

class WordGuessGameScreen extends StatefulWidget {
  const WordGuessGameScreen({Key? key}) : super(key: key);

  @override
  _WordGuessGameScreenState createState() => _WordGuessGameScreenState();
}

class _WordGuessGameScreenState extends State<WordGuessGameScreen> {
  final List<Map<String, dynamic>> _wordList = [
    {
      'word': 'FLUTTER',
      'hint': 'Popular mobile development framework',
      'revealedLetters': [0, 5] // Reveal first and last letters
    },
    {
      'word': 'CODING',
      'hint': 'Programming activity',
      'revealedLetters': [0, 4]
    },
    {
      'word': 'MOBILE',
      'hint': 'Portable electronic device',
      'revealedLetters': [1, 5]
    },
    {
      'word': 'DART',
      'hint': 'Programming language by Google',
      'revealedLetters': [0, 3]
    },
    {
      'word': 'ANDROID',
      'hint': 'Mobile operating system',
      'revealedLetters': [0, 6]
    },
    {
      'word': 'DEVELOPER',
      'hint': 'Software creation professional',
      'revealedLetters': [0, 8]
    },
    {
      'word': 'MINDFUL',
      'hint': 'Being aware and present',
      'revealedLetters': [0, 6]
    },
    {
      'word': 'RELAX',
      'hint': 'To become less tense',
      'revealedLetters': [0, 4]
    },
    {
      'word': 'BREATHE',
      'hint': 'Take air into lungs',
      'revealedLetters': [0, 6]
    },
    {
      'word': 'PEACE',
      'hint': 'State of tranquility',
      'revealedLetters': [0, 4]
    }
  ];

  late String _currentWord;
  late List<String> _displayWord;
  late String _hint;
  late List<int> _revealedLetters;
  int _attempts = 6;
  int _score = 0;
  final TextEditingController _guessController = TextEditingController();
  final Set<String> _guessedLetters = {};
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    // Select a random word from the list
    final selectedWord = _wordList[Random().nextInt(_wordList.length)];
   
    setState(() {
      _currentWord = selectedWord['word'];
      _hint = selectedWord['hint'];
      _revealedLetters = List<int>.from(selectedWord['revealedLetters']);
      _guessedLetters.clear();
      _gameOver = false;
     
      // Initialize display word with underscores
      _displayWord = List.filled(_currentWord.length, '_');
     
      // Reveal specified letters
      for (int index in _revealedLetters) {
        _displayWord[index] = _currentWord[index];
        _guessedLetters.add(_currentWord[index]);
      }
     
      _attempts = 6;
    });
  }

  void _checkGuess() {
    if (_gameOver) return;
    
    String guess = _guessController.text.trim().toUpperCase();
    _guessController.clear();
    
    if (guess.isEmpty) return;
    
    if (guess.length == 1) {
      // Single letter guess
      _checkLetterGuess(guess);
    } else if (guess.length == _currentWord.length) {
      // Full word guess
      _checkWordGuess(guess);
    } else {
      // Invalid guess length
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a single letter or the full ${_currentWord.length}-letter word'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
  
  void _checkLetterGuess(String letter) {
    if (_guessedLetters.contains(letter)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You already guessed the letter "$letter"'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }
    
    setState(() {
      _guessedLetters.add(letter);
      
      if (_currentWord.contains(letter)) {
        // Correct letter guess
        for (int i = 0; i < _currentWord.length; i++) {
          if (_currentWord[i] == letter) {
            _displayWord[i] = letter;
          }
        }
        
        // Check if word is complete
        if (!_displayWord.contains('_')) {
          _gameOver = true;
          _score++;
          _showSuccessDialog();
        }
      } else {
        // Incorrect letter guess
        _attempts--;
        if (_attempts <= 0) {
          _gameOver = true;
          _showGameOverDialog();
        }
      }
    });
  }
  
  void _checkWordGuess(String word) {
    setState(() {
      if (word == _currentWord) {
        // Correct word guess
        _displayWord = _currentWord.split('');
        _gameOver = true;
        _score++;
        _showSuccessDialog();
      } else {
        // Incorrect word guess
        _attempts -= 2; // Penalize more for incorrect word guess
        if (_attempts <= 0) {
          _gameOver = true;
          _showGameOverDialog();
        }
      }
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('You guessed the word: $_currentWord'),
              const SizedBox(height: 10),
              Text('Your score: $_score'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Next Word'),
              onPressed: () {
                Navigator.of(context).pop();
                _startNewGame();
              },
            ),
          ],
        );
      },
    );
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('The word was: $_currentWord'),
              const SizedBox(height: 10),
              Text('Final score: $_score'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _score = 0;
                  _startNewGame();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _showHintDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hint'),
          content: Text(_hint),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildKeyboard() {
    const letters = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['Z', 'X', 'C', 'V', 'B', 'N', 'M']
    ];
    
    return Column(
      children: letters.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((letter) {
              bool isGuessed = _guessedLetters.contains(letter);
              bool isCorrect = _currentWord.contains(letter) && isGuessed;
              
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: ElevatedButton(
                  onPressed: isGuessed || _gameOver 
                      ? null 
                      : () {
                          _guessController.text = letter;
                          _checkLetterGuess(letter);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isCorrect ? Colors.green : Colors.blue,
                    disabledBackgroundColor: isCorrect ? Colors.green.shade300 : Colors.grey,
                    minimumSize: const Size(36, 36),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    letter,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Guess Game'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: _showHintDialog,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Score and attempts
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Score: $_score',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Attempts: $_attempts',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _attempts <= 2 ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Word display
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_currentWord.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 30,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.deepPurple.shade300,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _displayWord[index] == '_' ? '' : _displayWord[index],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Input field for guessing
              TextField(
                controller: _guessController,
                decoration: InputDecoration(
                  hintText: 'Enter a letter or the whole word',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _checkGuess,
                  ),
                ),
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.characters,
                maxLength: _currentWord.length,
                enabled: !_gameOver,
                onSubmitted: (_) => _checkGuess(),
              ),
              
              const SizedBox(height: 10),
              
              // On-screen keyboard
              Expanded(
                child: Center(
                  child: _buildKeyboard(),
                ),
              ),
              
              // New game button
              if (_gameOver)
                ElevatedButton(
                  onPressed: _startNewGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text('New Game'),
                ),
                
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _guessController.dispose();
    super.dispose();
  }
}
