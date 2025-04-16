class GrammarCategoryResponse {
  final int id;
  final String title;
  final List<GrammarItem> items;

  GrammarCategoryResponse({required this.id, required this.title, required this.items});

  factory GrammarCategoryResponse.fromJson(Map<String, dynamic> json) {
    return GrammarCategoryResponse(
      id: json['id'],
      title: json['title'],
      items: (json['items'] as List)
          .map((item) => GrammarItem.fromJson(item))
          .toList(),
    );
  }
}

class GrammarItem {
  final int id;
  final String title;

  GrammarItem({required this.id, required this.title});

  factory GrammarItem.fromJson(Map<String, dynamic> json) {
    return GrammarItem(
      id: json['id'],
      title: json['title'],
    );
  }
}
