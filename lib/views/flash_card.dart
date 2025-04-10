import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlashcardScreen extends ConsumerStatefulWidget {
  const FlashcardScreen({super.key});

  @override
  ConsumerState<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends ConsumerState<FlashcardScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Dữ liệu flashcard gốc (nếu cần reset)
  final List<Map<String, String>> originalFlashcards = [
    {
      'image': 'images/cat.png',
      'word': 'characteristic',
      'phonetic': '/ˌkærəktəˈrɪstɪk/',
      'audio':
          'https://commondatastorage.googleapis.com/codeskulptor-assets/jump.ogg',
    },
    {
      'image': 'images/cat.png',
      'word': 'warranty',
      'phonetic': '/ˈwɒrənti/',
      'audio':
          'https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg',
    },
    {
      'image': 'images/cat.png',
      'word': 'warranty',
      'phonetic': '/ˈwɒrənti/',
      'audio':
          'https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg',
    },
    {
      'image': 'images/cat.png',
      'word': 'warranty',
      'phonetic': '/ˈwɒrənti/',
      'audio':
          'https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg',
    },
    {
      'image': 'images/cat.png',
      'word': 'warranty',
      'phonetic': '/ˈwɒrənti/',
      'audio':
          'https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg',
    },
    {
      'image': 'images/cat.png',
      'word': 'warranty',
      'phonetic': '/ˈwɒrənti/',
      'audio':
          'https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg',
    },
    {
      'image': 'images/cat.png',
      'word': 'warranty',
      'phonetic': '/ˈwɒrənti/',
      'audio':
          'https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg',
    },
    {
      'image': 'images/cat.png',
      'word': 'warranty',
      'phonetic': '/ˈwɒrənti/',
      'audio':
          'https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg',
    },
    // Thêm flashcard khác tại đây
  ];

  late List<Map<String, String>> flashcards;
  int understoodCount = 0;
  int notUnderstoodCount = 0;

  @override
  void initState() {
    super.initState();
    flashcards = List.from(originalFlashcards);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget buildFlashcard(Map<String, String> card) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(card['image']!, height: 200),
            const SizedBox(height: 16),
            Text(
              card['word']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              card['phonetic']!,
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => _audioPlayer.play(UrlSource(card['audio']!)),
                  icon: const Icon(Icons.volume_up, color: Colors.blue),
                ),
                const Icon(Icons.volume_up, color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Flashcards"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.close, color: Colors.black),
        actions: [
          const Icon(Icons.emoji_events, color: Colors.orangeAccent),
          const SizedBox(width: 8),
          const Icon(Icons.flag, color: Colors.redAccent),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LinearProgressIndicator(
              value:
                  flashcards.isNotEmpty
                      ? (1 - flashcards.length / originalFlashcards.length)
                      : 1.0,
              backgroundColor: Colors.grey.shade300,
              color: Colors.blue,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child:
                flashcards.isEmpty
                    ? const Center(
                      child: Text("Bạn đã hoàn thành tất cả flashcard!"),
                    )
                    : Center(
                      child: Stack(
                        children:
                            flashcards.asMap().entries.map((entry) {
                              int index = entry.key;
                              var card = entry.value;

                              return Dismissible(
                                key: ValueKey(index),
                                direction: DismissDirection.horizontal,
                                onDismissed: (direction) {
                                  final understood =
                                      direction == DismissDirection.startToEnd;

                                  setState(() {
                                    flashcards.removeAt(index);
                                    if (understood) {
                                      understoodCount++;
                                    } else {
                                      notUnderstoodCount++;
                                      // Thêm lại học sau khi dismiss xong
                                      Future.microtask(() {
                                        setState(() {
                                          flashcards.add(
                                            Map<String, String>.from(card),
                                          );
                                        });
                                      });
                                    }
                                  });
                                },
                                background: Container(
                                  color: Colors.greenAccent,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 32),
                                  child: const Text("Đã hiểu"),
                                ),
                                secondaryBackground: Container(
                                  color: Colors.redAccent,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 32),
                                  child: const Text("Học lại"),
                                ),
                                child: buildFlashcard(card),
                              );
                            }).toList(),
                      ),
                    ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 22,
                child: Text(
                  "$notUnderstoodCount",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 22,
                child: Text(
                  "$understoodCount",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    flashcards = List.from(originalFlashcards);
                    understoodCount = 0;
                    notUnderstoodCount = 0;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Tùy chọn"),
              ),
              IconButton(icon: const Icon(Icons.play_arrow), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
