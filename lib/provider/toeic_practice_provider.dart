import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/toeic_practice/mock_toeic_practice_respository.dart';
import 'package:toeic/data/repositories/toeic_practice/toeic_practice_repository.dart';
import 'package:toeic/data/services/api/api_clients/toeic_practice_api_client.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/viewmodel/toeic_test_page_state.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/viewmodel/toeic_test_page_view_model.dart';

//Provider for ToeicTestApiClient
final toeicPracticeApiClientProvider = Provider<ToeicPracticeApiClient>((ref) {
  return ToeicPracticeApiClient();
});

//Provider for ToeicPracticeRepository
final toeicPracticeRepositoryProvider = Provider<ToeicPracticeRepository>((
  ref,
) {
  final apiClient = ref.read(toeicPracticeApiClientProvider);
  return ToeicPracticeRepository(toeicTestApiClient: apiClient);
});

//Provider for ToeicTestPageViewModel
final toeicTestScreenViewModelProvider = StateNotifierProvider.autoDispose
    .family<ToeicTestPageViewModel, ToeicTestPageState, int>((ref, testId) {
      final repo = ref.watch(toeicPracticeRepositoryProvider);
      // final mockRepo = MockToeicPracticeRepository();
      return ToeicTestPageViewModel(
        toeicPracticeRepository: repo,
        testId: testId,
      );
    });
