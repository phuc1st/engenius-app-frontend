import 'package:flutter/material.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/gradient_app_bar.dart';

class StudySessionScreen extends StatefulWidget {
  const StudySessionScreen({super.key});

  @override
  State<StudySessionScreen> createState() => _StudySessionScreenState();
}

class _StudySessionScreenState extends State<StudySessionScreen> {
  bool _isPaused = false;
  int _remainingSeconds = 25 * 60; // 25 minutes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text(
          'Chế độ tập trung',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.primary,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: AppColors.primary,
            onPressed: () {
              // TODO: Show settings
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.primaryGradient,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimer(),
            const SizedBox(height: 32),
            _buildControls(),
            const SizedBox(height: 48),
            _buildParticipants(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimer() {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');

    return Column(
      children: [
        Text(
          '$minutes:$seconds',
          style: AppTextStyles.displayLarge.copyWith(
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Thời gian còn lại',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildControlButton(
          icon: _isPaused ? Icons.play_arrow : Icons.pause,
          label: _isPaused ? 'Tiếp tục' : 'Tạm dừng',
          onPressed: () {
            setState(() {
              _isPaused = !_isPaused;
            });
          },
        ),
        const SizedBox(width: 24),
        _buildControlButton(
          icon: Icons.stop,
          label: 'Kết thúc',
          onPressed: () {
            Navigator.pop(context);
          },
          color: AppColors.error,
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: (color ?? AppColors.primary).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              size: 32,
              color: color ?? AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: color ?? AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildParticipants() {
    return Column(
      children: [
        Text(
          'Người tham gia',
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildParticipantAvatar('Bạn', true),
            const SizedBox(width: 16),
            _buildParticipantAvatar('+', false),
          ],
        ),
      ],
    );
  }

  Widget _buildParticipantAvatar(String label, bool isActive) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary.withOpacity(0.1) : Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.primary : Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
} 