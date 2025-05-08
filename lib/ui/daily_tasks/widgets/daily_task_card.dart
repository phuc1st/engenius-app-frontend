import 'package:flutter/material.dart';
import 'package:toeic/data/services/api/model/daily_task/daily_task.dart';

class DailyTaskCard extends StatelessWidget {
  final DailyTask task;
  final VoidCallback onComplete;

  const DailyTaskCard({
    super.key,
    required this.task,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                _buildTaskTypeChip(task.taskType),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${task.experiencePoints} XP',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (!task.isCompleted)
                  ElevatedButton(
                    onPressed: onComplete,
                    child: const Text('Hoàn thành'),
                  )
                else
                  const Chip(
                    label: Text('Đã hoàn thành'),
                    backgroundColor: Colors.green,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskTypeChip(String taskType) {
    Color color;
    String label;

    switch (taskType) {
      case 'VOCABULARY':
        color = Colors.blue;
        label = 'Từ vựng';
        break;
      case 'GRAMMAR':
        color = Colors.purple;
        label = 'Ngữ pháp';
        break;
      case 'LISTENING':
        color = Colors.orange;
        label = 'Nghe';
        break;
      case 'READING':
        color = Colors.green;
        label = 'Đọc';
        break;
      case 'SPEAKING':
        color = Colors.red;
        label = 'Nói';
        break;
      default:
        color = Colors.grey;
        label = taskType;
    }

    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    );
  }
} 