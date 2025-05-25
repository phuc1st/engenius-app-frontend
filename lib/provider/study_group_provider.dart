import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/group_study_repository.dart';
import 'package:toeic/ui/study_group/viewmodels/create_group_viewmodel.dart';
import 'package:toeic/ui/study_group/viewmodels/create_group_state.dart';
import 'package:toeic/ui/study_group/viewmodels/group_list_state.dart';
import 'package:toeic/ui/study_group/viewmodels/group_list_viewmodel.dart';
import 'package:toeic/ui/study_group/viewmodels/joined_group_list_state.dart';
import 'package:toeic/ui/study_group/viewmodels/joined_group_list_viewmodel.dart';
import 'package:toeic/ui/study_group/viewmodels/group_chat_viewmodel.dart';
import 'package:toeic/ui/study_group/viewmodels/group_chat_state.dart';

final groupStudyRepositoryProvider = Provider<GroupStudyRepository>((ref) {
  return GroupStudyRepository();
});

final createGroupViewModelProvider = StateNotifierProvider<CreateGroupViewModel, CreateGroupState>((ref) {
  final repository = ref.read(groupStudyRepositoryProvider);
  return CreateGroupViewModel(repository: repository);
});

final groupListViewModelProvider = StateNotifierProvider<GroupListViewModel, GroupListState>((ref) {
  final repository = ref.read(groupStudyRepositoryProvider);
  return GroupListViewModel(repository: repository);
});

final joinedGroupListViewModelProvider = StateNotifierProvider<JoinedGroupListViewModel, JoinedGroupListState>((ref) {
  final repository = ref.read(groupStudyRepositoryProvider);
  return JoinedGroupListViewModel(repository: repository);
});

final groupChatViewModelProvider = StateNotifierProvider<GroupChatViewModel, GroupChatState>((ref) {
  final repository = ref.read(groupStudyRepositoryProvider);
  return GroupChatViewModel(repository: repository);
});