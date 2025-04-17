class GrammarSection {
  final String sectionTitle;
  final List<GrammarItem> items;

  GrammarSection({
    required this.sectionTitle,
    required this.items,
  });

  factory GrammarSection.fromJson(Map<String, dynamic> json) {
    return GrammarSection(
      sectionTitle: json['sectionTitle'] ?? '',
      items: (json['items'] as List)
          .map((item) => GrammarItem.fromJson(item))
          .toList(),
    );
  }
}

class GrammarItem {
  final String name;
  final Map<String, List<String>> formulas;
  final List<String> signalWords;
  final String data;
  GrammarItem({
    required this.name,
    required this.formulas,
    required this.signalWords,
    required this.data
  });

  factory GrammarItem.fromJson(Map<String, dynamic> json) {
    final formulasMap = <String, List<String>>{};
    if (json['formulas'] != null) {
      (json['formulas'] as Map<String, dynamic>).forEach((key, value) {
        formulasMap[key] = List<String>.from(value);
      });
    }

    return GrammarItem(
      name: json['name'] ?? '',
      formulas: formulasMap,
      signalWords: List<String>.from(json['signalWords'] ?? []),
      data: json['data'] ?? ''
    );
  }
}
