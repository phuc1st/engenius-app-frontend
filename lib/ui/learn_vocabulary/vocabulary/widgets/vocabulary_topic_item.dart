import 'package:flutter/material.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/user_vocabulary_topic_progress_response.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/vocabulary_topic_response.dart';

class VocabularyTopicItem extends StatelessWidget {
  final UserVocabularyTopicProgressResponse topic;
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
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        shadowColor: Colors.blue.withOpacity(0.1),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.blue[100]!,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    _getIconForTopic(topic.topicName),
                    color: Colors.blue[700],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              topic.topicName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                          ),
                          if (topic.newTopic)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.green[200]!,
                                ),
                              ),
                              child: Text(
                                'Mới',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildProgressIndicator(topic.accuracy ?? 0),
                          const SizedBox(width: 8),
                          Text(
                            "${topic.accuracy ?? 0}%",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.blue[700],
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(int accuracy) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: accuracy / 100,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(
            accuracy >= 80
                ? Colors.green[400]!
                : accuracy >= 50
                    ? Colors.orange[400]!
                    : Colors.red[400]!,
          ),
          minHeight: 6,
        ),
      ),
    );
  }

  IconData _getIconForTopic(String topicName) {
    final lowerTopic = topicName.toLowerCase();
    if (lowerTopic.contains('business') || lowerTopic.contains('marketing')) {
      return Icons.business;
    } else if (lowerTopic.contains('travel') || lowerTopic.contains('trip')) {
      return Icons.flight;
    } else if (lowerTopic.contains('food') || lowerTopic.contains('restaurant')) {
      return Icons.restaurant;
    } else if (lowerTopic.contains('health') || lowerTopic.contains('medical')) {
      return Icons.medical_services;
    } else if (lowerTopic.contains('education') || lowerTopic.contains('school')) {
      return Icons.school;
    } else if (lowerTopic.contains('technology') || lowerTopic.contains('computer')) {
      return Icons.computer;
    } else if (lowerTopic.contains('sport') || lowerTopic.contains('fitness')) {
      return Icons.sports;
    } else if (lowerTopic.contains('entertainment') || lowerTopic.contains('movie')) {
      return Icons.movie;
    } else if (lowerTopic.contains('shopping') || lowerTopic.contains('store')) {
      return Icons.shopping_bag;
    } else {
      return Icons.menu_book;
    }
  }
}
