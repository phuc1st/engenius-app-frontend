import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/learn_vocabulary/learn_vocabulary_repository.dart';
import 'package:toeic/data/repositories/learn_vocabulary/mock_learn_vocabulary_repository.dart';
import 'package:toeic/data/services/api/api_clients/learn_vocabulary_api_client.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/topic_response.dart';
import 'package:toeic/ui/learn_vocabulary/vocabulary/view_models/vocabulary_view_model.dart';

final learnVocabularyApiClientProvider = Provider<LearnVocabularyApiClient>((
  ref,
) {
  return LearnVocabularyApiClient();
});

final learnVocabularyRepositoryProvider = Provider<LearnVocabularyRepository>((
  ref,
) {
  final apiClient = ref.read(learnVocabularyApiClientProvider);
  return LearnVocabularyRepository(learnVocabularyApiClient: apiClient);
});

final vocabularyViewModelProvider = StateNotifierProvider<
  VocabularyViewModel,
  AsyncValue<List<TopicResponse>>
>((ref) {
  final learnVocabularyRepository = ref.read(learnVocabularyRepositoryProvider);
  return VocabularyViewModel(
    learnVocabularyRepository: MockLearnVocabularyRepository(),
  );
});
