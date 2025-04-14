import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/learn_vocabulary/learn_vocabulary_repository.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/topic_response.dart';
import 'package:toeic/data/services/api/model/login_request/login_request.dart';
import 'package:toeic/data/services/api/model/login_response/login_response.dart';
import 'package:toeic/utils/result.dart';

class VocabularyViewModel extends StateNotifier<AsyncValue<List<TopicResponse>>> {
  final LearnVocabularyRepository _learnVocabularyRepository;

  VocabularyViewModel({required LearnVocabularyRepository learnVocabularyRepository})
    : _learnVocabularyRepository = learnVocabularyRepository,
      super(AsyncValue.loading());

  Future<void> getTopics() async {
    state = const AsyncValue.loading();
    final result = await _learnVocabularyRepository.getTopics();

    if (result is Ok<List<TopicResponse>>) {
      state = AsyncValue.data(result.value);
    } else if (result is Error<List<TopicResponse>>) {
      state = AsyncValue.error(result.error.toString(), StackTrace.current);
    }
  }
}
