import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/provider/learn_vocabulary_provider.dart';
import 'package:toeic/routing/routes.dart';
import 'package:toeic/ui/learn_vocabulary/vocabulary/widgets/vocabulary_header.dart';
import 'package:toeic/ui/learn_vocabulary/vocabulary/widgets/vocabulary_topic_item.dart';

class VocabularyScreen extends ConsumerStatefulWidget {
  const VocabularyScreen({super.key});

  @override
  ConsumerState<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends ConsumerState<VocabularyScreen> {
  @override
  void initState() {
    super.initState();
    // Gọi API ngay khi vào màn hình
    Future.microtask(() {
      ref.read(vocabularyViewModelProvider.notifier).getTopics();
    });
  }

  /*final List<Map<String, dynamic>> topics = [
    {"title": "Contracts", "accuracy": 83, "isNew": false},
    {"title": "Marketing", "accuracy": 0, "isNew": true},
    {"title": "Warranties", "accuracy": 0, "isNew": true},
    {"title": "Business Planning", "accuracy": 0, "isNew": true},
    {"title": "Conferences", "accuracy": 0, "isNew": true},
  ];*/

  @override
  Widget build(BuildContext context) {
    final topicsState = ref.watch(vocabularyViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("VOCABULARY", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: topicsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text("Lỗi: $error")),
        data:
            (topics) => Column(
              children: [
                VocabularyHeader(numTest: topics.length, accuracy: 2),
                Expanded(
                  child: ListView.builder(
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
                      final topic = topics[index];
                      return VocabularyTopicItem(
                        topic: topic,
                        onTap:
                            () => Navigator.pushNamed(
                              context,
                              Routes.topicDetail,
                              arguments: topic,
                            ),
                      );
                    },
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
