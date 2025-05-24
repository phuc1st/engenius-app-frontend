import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/group_study_repository.dart';
import 'package:toeic/ui/study_group/viewmodels/create_group_viewmodel.dart';
import 'package:toeic/ui/study_group/viewmodels/create_group_state.dart';

final groupStudyRepositoryProvider = Provider<GroupStudyRepository>((ref) {
  return GroupStudyRepository();
});

final createGroupViewModelProvider = StateNotifierProvider<CreateGroupViewModel, CreateGroupState>((ref) {
  final repository = ref.read(groupStudyRepositoryProvider);
  return CreateGroupViewModel(repository: repository);
}); 