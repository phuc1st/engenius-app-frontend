// import 'package:toeic/data/repositories/toeic_practice/toeic_practice_repository.dart';
// import 'package:toeic/data/services/api/api_clients/toeic_practice_api_client.dart';
// import 'package:toeic/data/services/api/model/api_response.dart';
// import 'package:toeic/data/services/api/model/learn_vocabulary_response/flash_card_response.dart';
// import 'package:toeic/data/services/api/model/toeic_practice//toeic_test.dart';
// import 'package:toeic/utils/result.dart';
//
// class MockToeicPracticeRepository implements ToeicPracticeRepository {
//
//   @override
//   Future<Result<ToeicTest>> getToeicTest(String toeicTestId) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//
//     final mockTest = ToeicTest(
//       id: toeicTestId,
//       name: 'Mock Test $toeicTestId',
//       createdAt: DateTime.now(),
//       parts: [
//         ToeicPart(
//           partNumber: 1,
//           blocks: [
//             QuestionBlock(
//               audioUrl: null,
//               imageUrl: null,
//               passage: null,
//               questions: [
//                 Question(number: 1, text: 'What is your name?', options: ['A', 'B', 'C', 'D']),
//                 Question(number: 2, text: 'How old are you?', options: ['A', 'B', 'C', 'D']),
//               ],
//             ),
//           ],
//         ),
//         ToeicPart(
//           partNumber: 2,
//           blocks: [
//             QuestionBlock(
//               audioUrl: null,
//               imageUrl: null,
//               passage: 'This is a passage example.',
//               questions: [
//                 Question(number: 3, text: 'Where do you live?', options: ['A', 'B', 'C', 'D']),
//                 Question(number: 4, text: 'What do you do?', options: ['A', 'B', 'C', 'D']),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//
//     return Result.ok(mockTest);
//   }
//
//   @override
//   Future<Result<List<FlashCardResponse>>> getFlashCards(String topicId) {
//     // TODO: implement getFlashCards
//     throw UnimplementedError();
//   }
//
//   @override
//   Result<T> handleApiResponse<T>(ApiResponse<T> response) {
//     // TODO: implement handleApiResponse
//     throw UnimplementedError();
//   }
//
//   @override
//   // TODO: implement toeicTestApiClient
//   ToeicPracticeApiClient get toeicTestApiClient => throw UnimplementedError();
// }
