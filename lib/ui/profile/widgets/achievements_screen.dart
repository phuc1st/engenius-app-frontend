import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_styles.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thành tích'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAchievementCard(
              title: 'Tổng điểm kinh nghiệm',
              value: '${user?.experiencePoints ?? 0} XP',
              icon: Icons.emoji_events,
              color: Colors.amber,
            ),
            const SizedBox(height: 16),
            _buildAchievementCard(
              title: 'Số bài test đã làm',
              value: '${user?.completedTests?.length ?? 0} bài',
              icon: Icons.assignment_turned_in,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            _buildAchievementCard(
              title: 'Số nhóm học đã tham gia',
              value: '${user?.studyGroups?.length ?? 0} nhóm',
              icon: Icons.groups,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            Text(
              'Huy hiệu',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 6, // TODO: Replace with actual badges count
              itemBuilder: (context, index) {
                return _buildBadgeItem(
                  title: 'Huy hiệu ${index + 1}',
                  isUnlocked: index < 3, // TODO: Replace with actual badge status
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem({
    required String title,
    required bool isUnlocked,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isUnlocked ? Icons.emoji_events : Icons.lock,
            size: 32,
            color: isUnlocked ? Colors.amber : Colors.grey,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
} 