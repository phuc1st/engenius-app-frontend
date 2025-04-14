List<T> listFromJson<T>(
    dynamic json,
    T Function(Map<String, dynamic> json) fromJsonT,
    ) {
  if (json is List) {
    return json.map<T>((item) => fromJsonT(item as Map<String, dynamic>)).toList();
  }
  throw FormatException("Invalid JSON format for list");
}
