class ApiResponse<T> {
  final int code;
  final T? result;
  final String? message;

  ApiResponse({required this.code, this.result, this.message});

  // Hàm chuyển đổi từ JSON sang ApiResponse
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return ApiResponse<T>(
      code: json['code'],
      // Lấy mã code từ JSON
      result: json['result'] != null ? fromJsonT(json['result']) : null,
      // Chuyển đổi result nếu có
      message:
          json.containsKey('message')
              ? json['message']
              : null, // Nếu có trường message, lấy nó, nếu không thì null
    );
  }
}
