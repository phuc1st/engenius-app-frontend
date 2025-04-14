import 'package:flutter/material.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/topic_response.dart';

class VocabularyTopicItem extends StatelessWidget {
  final TopicResponse topic;
  final VoidCallback onTap;

  const VocabularyTopicItem({
    super.key,
    required this.topic,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        shadowColor: Colors.grey.shade100,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16), // Để hiệu ứng bo góc đúng
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            topic.topicName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          if (topic.isNew)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAF1FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Mới',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Chính xác: ${topic.accuracy}%",
                        style: TextStyle(
                          color: topic.accuracy > 0 ? Colors.green : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB9B5F6),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(Icons.double_arrow, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
