import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/config/app_sesstion.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/user_vocabulary_topic_progress_response.dart';
import 'package:toeic/provider/learn_vocabulary_provider.dart';
import 'package:toeic/routing/routes.dart';
import 'package:toeic/utils/result.dart';

class TopicDetailScreen extends ConsumerStatefulWidget {
  final UserVocabularyTopicProgressResponse topic;

  const TopicDetailScreen({super.key, required this.topic});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TopicDetailScreenState();
}

class _TopicDetailScreenState extends ConsumerState<TopicDetailScreen> {
  bool _isLoading = false;

  Future<void> onStudy() async {
    setState(() {
      _isLoading = true;
    });
    try {
      int? progressId = widget.topic.id;

      if (progressId == null) {
        final result = await ref
            .read(learnVocabularyRepositoryProvider)
            .createNewTopicProgress(
              widget.topic.vocabularyTopicId,
            );
        if (!mounted) return;

        if (result is Ok<UserVocabularyTopicProgressResponse>) {
          progressId = result.value.id;
        } else if (result is Error<UserVocabularyTopicProgressResponse>) {
          debugPrint("Error creating progress: ${result.error}");

          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Lỗi'),
                  content: Text(result.error.toString()),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Đóng'),
                    ),
                  ],
                ),
          );

          return;
        }
      }

      if (progressId != null) {
        Navigator.pushNamed(context, Routes.flashCard, arguments: progressId);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FBFF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          widget.topic.topicName,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(Icons.emoji_events_outlined, color: Colors.orange),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Accuracy Card
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Điểm số mới nhất được ghi lại",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 10),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 130,
                            height: 130,
                            child: CircularProgressIndicator(
                              value: widget.topic.accuracy / 100.0,
                              strokeWidth: 10,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue,
                              ),
                            ),
                          ),
                          Text(
                            "${widget.topic.accuracy}%\nChính xác",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFEDF0FF),
                                foregroundColor: Colors.black,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: TextButton(
                                onPressed: onStudy,
                                child: Text("Học"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFEDF0FF),
                                foregroundColor: Colors.black,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text("Chơi game"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Stats
              _buildStatRow(
                "Đã thuộc",
                widget.topic.memorized,
                Colors.green,
                Icons.check_circle_outline,
              ),
              _buildStatRow("Chưa thuộc", 0, Colors.red, Icons.cancel_outlined),
              _buildStatRow(
                "Đã học",
                widget.topic.studied,
                Colors.orange,
                Icons.auto_stories,
              ),
              _buildStatRow("Đánh dấu", 0, Colors.pink, Icons.bookmark_border),
            ],
          ),
          if (_isLoading)
            Stack(
              children: const [
                ModalBarrier(
                  dismissible: false,
                  color: Colors.black45,
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, int count, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Text(
              count.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            count == 0
                ? Text("Trống", style: TextStyle(color: Colors.grey))
                : TextButton(
                  onPressed: () {},
                  child: Text(
                    "Luyện tập >",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
