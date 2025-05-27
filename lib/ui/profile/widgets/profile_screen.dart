import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_styles.dart';
import '../view_models/profile_view_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(profileViewModelProvider.notifier).getMyProfile());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileViewModelProvider);

    if (state.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.error != null) {
      return Scaffold(
        body: Center(
          child: Text('Lỗi: ${state.error}'),
        ),
      );
    }

    final profile = state.userProfileResponse;
    if (profile == null) {
      return const Scaffold(
        body: Center(
          child: Text('Không tìm thấy thông tin người dùng'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ cá nhân'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit profile screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: const NetworkImage('https://i.pravatar.cc/1'),
                    child: null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoSection(
              title: 'Thông tin cá nhân',
              children: [
                _buildInfoItem(
                  icon: Icons.person,
                  label: 'Họ và tên',
                  value: '${profile.firstName} ${profile.lastName}',
                ),
                _buildInfoItem(
                  icon: Icons.email,
                  label: 'Email',
                  value: profile.email,
                ),
                _buildInfoItem(
                  icon: Icons.person_outline,
                  label: 'Tên đăng nhập',
                  value: profile.username,
                ),
                _buildInfoItem(
                  icon: Icons.location_on,
                  label: 'Thành phố',
                  value: profile.city,
                ),
                _buildInfoItem(
                  icon: Icons.calendar_today,
                  label: 'Ngày sinh',
                  value: '${profile.dob.day}/${profile.dob.month}/${profile.dob.year}',
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              title: 'Thông tin học tập',
              children: [
                _buildInfoItem(
                  icon: Icons.school,
                  label: 'Trình độ',
                  value: 'Intermediate',
                ),
                _buildInfoItem(
                  icon: Icons.emoji_events,
                  label: 'Điểm kinh nghiệm',
                  value: '2,500 XP',
                ),
                _buildInfoItem(
                  icon: Icons.groups,
                  label: 'Nhóm học',
                  value: '3 nhóm',
                ),
                _buildInfoItem(
                  icon: Icons.timer,
                  label: 'Thời gian học',
                  value: '120 giờ',
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              title: 'Thành tích',
              children: [
                _buildAchievementItem(
                  icon: Icons.star,
                  title: 'Học viên xuất sắc',
                  description: 'Đạt được trong tháng 3/2024',
                  color: Colors.amber,
                ),
                _buildAchievementItem(
                  icon: Icons.emoji_events,
                  title: 'Chứng chỉ TOEIC 750+',
                  description: 'Đạt được trong tháng 2/2024',
                  color: Colors.blue,
                ),
                _buildAchievementItem(
                  icon: Icons.local_fire_department,
                  title: 'Học viên chăm chỉ',
                  description: 'Đạt được trong tháng 1/2024',
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to achievements screen
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Xem thành tích',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: 8),
        Container(
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
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 