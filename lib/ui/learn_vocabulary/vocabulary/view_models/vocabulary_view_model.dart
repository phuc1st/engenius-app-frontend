import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/config/app_sesstion.dart';
import 'package:toeic/data/repositories/learn_vocabulary/learn_vocabulary_repository.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/user_vocabulary_topic_progress_response.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/vocabulary_topic_response.dart';
import 'package:toeic/utils/result.dart';

class VocabularyViewModel extends StateNotifier<AsyncValue<List<UserVocabularyTopicProgressResponse>>> {
  final LearnVocabularyRepository _learnVocabularyRepository;

  VocabularyViewModel({required LearnVocabularyRepository learnVocabularyRepository})
    : _learnVocabularyRepository = learnVocabularyRepository,
      super(AsyncValue.loading());

  Future<void> getTopics() async {
    state = const AsyncValue.loading();
    final result = await _learnVocabularyRepository.getTopics(AppSession.userId);

    if (result is Ok<List<UserVocabularyTopicProgressResponse>>) {
      state = AsyncValue.data(result.value);
    } else if (result is Error<List<UserVocabularyTopicProgressResponse>>) {
      state = AsyncValue.error(result.error.toString(), StackTrace.current);
    }
  }
}
