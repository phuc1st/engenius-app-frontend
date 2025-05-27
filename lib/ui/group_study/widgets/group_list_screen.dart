import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/services/api/model/study_group/group_node_response.dart';
import 'package:toeic/provider/study_group_provider.dart';
import 'package:toeic/routing/routes.dart';
import 'package:toeic/ui/group_study/widgets/create_group_screen.dart';

import '../../../utils/app_text_styles.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/gradient_app_bar.dart';

class GroupListScreen extends ConsumerStatefulWidget {
  const GroupListScreen({super.key});

  @override
  ConsumerState<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends ConsumerState<GroupListScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(groupListViewModelProvider.notifier).loadGroups();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(groupListViewModelProvider.notifier).loadGroups();
    }
  }

  Future<void> _joinGroup(String groupId) async {
    final success = await ref
        .read(groupListViewModelProvider.notifier)
        .joinGroup(groupId);
    if (success && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Tham gia nhóm thành công')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(groupListViewModelProvider);

    return Scaffold(
      appBar: GradientAppBar(
        title:
            _isSearching
                ? TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm nhóm',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: AppColors.primary.withOpacity(0.7),
                    ),
                  ),
                  style: TextStyle(color: AppColors.primary),
                  onSubmitted: (query) {
                    ref
                        .read(groupListViewModelProvider.notifier)
                        .searchGroups(query);
                  },
                )
                : Text(
                  'Nhóm học tập',
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
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            color: AppColors.primary,
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  ref
                      .read(groupListViewModelProvider.notifier)
                      .searchGroups('');
                }
              });
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
        child: RefreshIndicator(
          onRefresh:
              () => ref
                  .read(groupListViewModelProvider.notifier)
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, Routes.createGroupStudy);
          ref
              .read(groupListViewModelProvider.notifier)
              .loadGroups(refresh: true);
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
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
          onTap: () {
            // TODO: Navigate to group detail
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          group.name[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
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
                    if (!group.joined)
                      ElevatedButton(
                        onPressed: () => _joinGroup(group.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Tham gia'),
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
