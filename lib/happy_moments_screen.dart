import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'dart:io' show File, Platform; 
import 'dart:typed_data'; 
import 'dart:ui' as ui; 
import 'journal_entry.dart';
import 'moment_detail.dart';
import 'mindful_games.dart';

class HappyMomentsScreen extends StatefulWidget {
  final bool fromMoodCheck;
  final String? currentMood;

  const HappyMomentsScreen({
    super.key,
    this.fromMoodCheck = false,
    this.currentMood,
  });

  @override
  State<HappyMomentsScreen> createState() => _HappyMomentsScreenState();
}

class _HappyMomentsScreenState extends State<HappyMomentsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final _uuid = const Uuid();

  List<JournalEntry> _happyMoments = [];
  bool _isLoading = true;
  String? _userCurrentMood;

  @override
  void initState() {
    super.initState();
    _userCurrentMood = widget.currentMood;
    _loadHappyMoments();
  }

  Future<void> _loadHappyMoments() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }
      final querySnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('journal_entries')
          .where('mood', isEqualTo: 'Happy')
          .orderBy('createdAt', descending: true)
          .get();
      final entries = querySnapshot.docs
          .map((doc) => JournalEntry.fromMap({...doc.data(), 'id': doc.id}))
          .toList();
      setState(() {
        _happyMoments = entries;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading happy moments: ${e.toString()}')),
      );
    }
  }

  Future<void> _addNewHappyMoment() async {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    XFile? image; 

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Add a Happy Moment',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: contentController,
                      decoration: const InputDecoration(
                        labelText: 'What made you happy?',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.photo_camera),
                            label: const Text('Add Photo'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              final XFile? pickedImage = await _picker.pickImage(
                                source: ImageSource.camera,
                                imageQuality: 70,
                              );
                              if (pickedImage != null) {
                                setState(() {
                                  image = pickedImage;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.photo_library),
                            label: const Text('Gallery'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              final XFile? pickedImage = await _picker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 70,
                              );
                              if (pickedImage != null) {
                                setState(() {
                                  image = pickedImage;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (image != null)
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: _buildImageProvider(image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  image = null;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        if (titleController.text.isEmpty ||
                            contentController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill in all fields')),
                          );
                          return;
                        }

                        Navigator.pop(context);

                        setState(() {
                          _isLoading = true;
                        });

                        try {
                          final user = _auth.currentUser;
                          if (user == null) {
                            throw Exception('User not logged in');
                          }

                          String? imageUrl;
                          if (image != null) {
                            final String fileName = '${_uuid.v4()}.jpg';
                            final Reference storageRef = _storage
                                .ref()
                                .child('users/${user.uid}/journal_images/$fileName');

                            // Upload based on platform
                            final UploadTask uploadTask;
                            if (Platform.isAndroid || Platform.isIOS) {
                              uploadTask = storageRef.putFile(File(image!.path));
                            } else {
                              // Web: Use bytes
                              final Uint8List bytes = await image!.readAsBytes();
                              uploadTask = storageRef.putData(bytes);
                            }

                            final TaskSnapshot snapshot = await uploadTask;
                            imageUrl = await snapshot.ref.getDownloadURL();
                          }

                          final entry = JournalEntry(
                            id: _uuid.v4(),
                            title: titleController.text,
                            content: contentController.text,
                            description: contentController.text,
                            mood: 'Happy',
                            imageUrl: imageUrl,
                            createdAt: DateTime.now(),
                          );

                          await _firestore
                              .collection('users')
                              .doc(user.uid)
                              .collection('journal_entries')
                              .doc(entry.id)
                              .set(entry.toMap());

                          await _loadHappyMoments();

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Happy moment added!')),
                            );
                          }
                        } catch (e) {
                          setState(() {
                            _isLoading = false;
                          });
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error adding happy moment: ${e.toString()}')),
                            );
                          }
                        }
                      },
                      child: const Text('Save Happy Moment', style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Helper method to provide the correct ImageProvider based on platform
  ImageProvider _buildImageProvider(XFile image) {
    if (Platform.isAndroid || Platform.isIOS) {
      return FileImage(File(image.path));
    } else {
      // Web: Use FutureBuilder to load bytes asynchronously
      return _AsyncMemoryImageProvider(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Your Happy Moments',
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
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  // Show mood-based message if coming from mood check and not happy
                  if (widget.fromMoodCheck && _userCurrentMood != 'Happy' && _happyMoments.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'We noticed you\'re feeling $_userCurrentMood today',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Here are some of your happy moments to help brighten your day:',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const MindfulnessGamesScreen()),
                              );
                            },
                            child: const Text('Go to Games Instead'),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: _happyMoments.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.sentiment_dissatisfied,
                                  size: 70,
                                  color: Colors.black54,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'No happy moments yet',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Add some memories that made you happy',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black45,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.add),
                                  label: const Text('Add Happy Moment'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: _addNewHappyMoment,
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Revisit your happiest moments',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.add, size: 20),
                                      label: const Text('Add'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      onPressed: _addNewHappyMoment,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: _happyMoments.length,
                                    itemBuilder: (context, index) {
                                      final moment = _happyMoments[index];
                                      return Card(
                                        elevation: 4,
                                        margin: const EdgeInsets.only(bottom: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => MomentDetailScreen(entry: moment),
                                              ),
                                            );
                                          },
                                          borderRadius: BorderRadius.circular(12),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              if (moment.imageUrl != null)
                                                ClipRRect(
                                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                                  child: Image.network(
                                                    moment.imageUrl!,
                                                    width: double.infinity,
                                                    height: 180,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Container(
                                                        height: 180,
                                                        color: Colors.grey[300],
                                                        child: const Center(
                                                          child: Icon(Icons.error, color: Colors.grey),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      moment.title,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      moment.content.length > 120
                                                          ? '${moment.content.substring(0, 120)}...'
                                                          : moment.content,
                                                      style: const TextStyle(fontSize: 16),
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.sentiment_very_satisfied,
                                                              color: Colors.amber,
                                                              size: 20,
                                                            ),
                                                            const SizedBox(width: 5),
                                                            Text(
                                                              'Happy',
                                                              style: TextStyle(
                                                                color: Colors.grey[600],
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          DateFormat('MMM d, yyyy').format(moment.createdAt),
                                                          style: TextStyle(
                                                            color: Colors.grey[600],
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
      ),
      floatingActionButton: _happyMoments.isNotEmpty
          ? FloatingActionButton(
              backgroundColor: Colors.black,
              foregroundColor: Colors.blue,
              onPressed: _addNewHappyMoment,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

// Custom ImageProvider for web to handle async byte loading
class _AsyncMemoryImageProvider extends ImageProvider<_AsyncMemoryImageProvider> {
  final XFile image;

  _AsyncMemoryImageProvider(this.image);

  @override
  Future<_AsyncMemoryImageProvider> obtainKey(ImageConfiguration configuration) {
    return Future.value(this);
  }

  @override
  ImageStreamCompleter loadImage(_AsyncMemoryImageProvider key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key),
      scale: 1.0,
    );
  }

  Future<ui.Codec> _loadAsync(_AsyncMemoryImageProvider key) async {
    final Uint8List bytes = await key.image.readAsBytes();
    return await ui.instantiateImageCodec(bytes);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is _AsyncMemoryImageProvider && other.image.path == image.path;
  }

  @override
  int get hashCode => image.path.hashCode;
}