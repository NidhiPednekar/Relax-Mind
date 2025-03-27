import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'journal_entry.dart';
import 'happy_moments_screen.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  String _currentMood = 'Happy';
  final List<String> _moodOptions = ['Happy', 'Neutral', 'Sad', 'Anxious', 'Excited'];
  bool _isUploading = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    
    if (photo != null) {
      setState(() {
        _selectedImage = File(photo.path);
      });
    }
  }

  Future<void> _saveJournalEntry() async {
  if (_selectedImage == null || _descriptionController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please add both an image and description')),
    );
    return;
  }

  setState(() {
    _isUploading = true;
  });

  try {
    // Get current user
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to add journal entries')),
      );
      return;
    }

    // Upload image to Firebase Storage
    final String fileName = '${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final Reference storageRef = FirebaseStorage.instance.ref().child('journal_images/$fileName');
    final UploadTask uploadTask = storageRef.putFile(_selectedImage!);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String imageUrl = await taskSnapshot.ref.getDownloadURL();

    // Extract title from description (first few words)
    String descriptionText = _descriptionController.text.trim();
    String title = descriptionText.split(" ").take(5).join(" "); // First 5 words as title
    String content = descriptionText;  // Full text as content

    // Create journal entry
    final entryId = const Uuid().v4();
    final entry = JournalEntry(
      id: entryId,
      title: title,  // Add title
      content: content,  // Add content
      description: descriptionText,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
      mood: _currentMood,
    );

    // Save to Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('journal_entries')
        .doc(entryId)
        .set(entry.toMap());

    // Clear form
    setState(() {
      _selectedImage = null;
      _descriptionController.clear();
      _isUploading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Journal entry saved successfully!')),
    );
  } catch (e) {
    setState(() {
      _isUploading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error saving journal entry: ${e.toString()}')),
    );
  }
}
  void _checkMoodAndNavigate() {
    if (_currentMood == 'Sad' || _currentMood == 'Anxious') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HappyMomentsScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Daily Journal',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HappyMomentsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _isUploading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'How are you feeling today?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentMood,
                          dropdownColor: Colors.black,
                          style: const TextStyle(color: Colors.white),
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              _currentMood = newValue!;
                            });
                            _checkMoodAndNavigate();
                          },
                          items: _moodOptions.map<DropdownMenuItem<String>>((String value) {
                            IconData icon;
                            switch (value) {
                              case 'Happy':
                                icon = Icons.sentiment_satisfied_alt;
                                break;
                              case 'Neutral':
                                icon = Icons.sentiment_neutral;
                                break;
                              case 'Sad':
                                icon = Icons.sentiment_dissatisfied;
                                break;
                              case 'Anxious':
                                icon = Icons.sentiment_very_dissatisfied;
                                break;
                              case 'Excited':
                                icon = Icons.mood;
                                break;
                              default:
                                icon = Icons.mood;
                            }
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  Icon(icon, color: Colors.blue),
                                  const SizedBox(width: 10),
                                  Text(value),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Capture Your Happy Moment',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (_selectedImage != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          _selectedImage!,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            icon: const Icon(Icons.refresh, color: Colors.blue),
                            label: const Text('Change Image', style: TextStyle(color: Colors.black87)),
                            onPressed: _pickImage,
                          ),
                        ],
                      ),
                    ] else ...[
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_photo_alternate,
                              size: 60,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Add an image',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.photo_library, size: 18),
                                  label: const Text('Gallery'),
                                  onPressed: _pickImage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.blue,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.camera_alt, size: 18),
                                  label: const Text('Camera'),
                                  onPressed: _takePhoto,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Describe your happy moment...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _saveJournalEntry,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Save Journal Entry',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HappyMomentsScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'View Past Happy Moments',
                        style: TextStyle(
                          color: Colors.black87,
                          decoration: TextDecoration.underline,
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