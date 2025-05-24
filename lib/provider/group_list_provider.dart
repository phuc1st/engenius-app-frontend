import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/group_study_repository.dart';
import 'package:toeic/ui/study_group/viewmodels/group_list_viewmodel.dart';
import 'package:toeic/ui/study_group/viewmodels/group_list_state.dart';

final groupStudyRepositoryProvider = Provider<GroupStudyRepository>((ref) {
  return GroupStudyRepository();
});

final groupListViewModelProvider = StateNotifierProvider<GroupListViewModel, GroupListState>((ref) {
  final repository = ref.read(groupStudyRepositoryProvider);
  return GroupListViewModel(repository: repository);
}); 