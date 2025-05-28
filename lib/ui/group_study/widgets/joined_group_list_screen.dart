import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/config/api_constants.dart';
import 'package:toeic/data/services/api/model/study_group/group_node_response.dart';
import 'package:toeic/data/services/local/user_profile_service.dart';
import 'package:toeic/provider/study_group_provider.dart';
import 'package:toeic/routing/route_arguments/group_chat_arguments.dart';
import 'package:toeic/routing/routes.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/gradient_app_bar.dart';

class JoinedGroupListScreen extends ConsumerStatefulWidget {
  const JoinedGroupListScreen({super.key});

  @override
  ConsumerState<JoinedGroupListScreen> createState() =>
      _JoinedGroupListScreenState();
}

class _JoinedGroupListScreenState extends ConsumerState<JoinedGroupListScreen> {
  final _scrollController = ScrollController();
//TODO MẤY CÁI GỌI API THÌ GỌI LẠI MỖI LẦN VÔ MÀN HÌNH CHỨ KHÔNG PHẢI INIT
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(joinedGroupListViewModelProvider.notifier).loadGroups();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(joinedGroupListViewModelProvider.notifier).loadGroups();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(joinedGroupListViewModelProvider);

    return Scaffold(
      appBar: GradientAppBar(
        title: Text(
          'Nhóm đã tham gia',
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
            icon: const Icon(Icons.search),
            color: AppColors.primary,
            onPressed: () => Navigator.pushNamed(context, Routes.groupStudy),
          )
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
        child: RefreshIndicator(
          onRefresh:
              () => ref
                  .read(joinedGroupListViewModelProvider.notifier)
                  .loadGroups(refresh: true),
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: state.groups.length + (state.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == state.groups.length) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                );
              }

              final group = state.groups[index];
              return _buildGroupCard(context, group);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, GroupNodeResponse group) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            final userProfile = await UserProfileService().getUserProfile();
            if (userProfile != null) {
              if (mounted) {
                Navigator.pushNamed(
                  context,
                  Routes.groupChat,
                  arguments: GroupChatArguments(
                    groupId: group.id,
                    groupName: group.name,
                    avatarUrl: group.avatarUrl,
                    userId: userProfile.id,
                    senderName: userProfile.username,
                  ),
                );
              }
            } else {
              // Xử lý trường hợp không có user profile
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Không thể lấy thông tin người dùng')),
              );
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blue[50],
                    backgroundImage: group.avatarUrl != null && group.avatarUrl.isNotEmpty
                        ? NetworkImage(ApiConstants.baseUrl+group.avatarUrl)
                        : null, // Nếu có avatarUrl thì load ảnh từ mạng, nếu không thì để nền trống
                    child: group.avatarUrl == null || group.avatarUrl.isEmpty
                        ? Text(
                      group.name[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    )
                        : null, // Nếu có ảnh thì không hiển thị chữ
                  ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(group.name, style: AppTextStyles.headlineSmall),
                          const SizedBox(height: 4),
                          Text(
                            '${group.memberCount} thành viên',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
