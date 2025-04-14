import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/utils/app_exception.dart';
import 'package:toeic/utils/result.dart';

abstract class BaseRepository {
  /// Hàm tiện ích xử lý ApiResponse chung cho các repository.
  Result<T> handleApiResponse<T>(ApiResponse<T> response) {
    if (response.code == 1000 && response.result != null) {
      return Result.ok(response.result!);
    } else {
      return Result.error(AppException(response.message ?? "Unknown error"));
    }
  }
}
