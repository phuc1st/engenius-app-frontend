class GrammarSection {
  final String sectionTitle;
  final String data;

  GrammarSection({required this.sectionTitle, required this.data});

  factory GrammarSection.fromJson(Map<String, dynamic> json) {
    return GrammarSection(
      sectionTitle: json['sectionTitle'] ?? '',
      data: json['data'] ?? '',
    );
  }
}
