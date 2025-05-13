class GrammarSection {
  final String sectionTitle;
  final String data;
  final List<GrammarContent> contents;

  GrammarSection({
    required this.sectionTitle,
    required this.data,
    required this.contents,
  });

  factory GrammarSection.fromJson(Map<String, dynamic> json) {
    final String data = json['data'] as String;
    final List<GrammarContent> contents = _parseContent(data);
    
    return GrammarSection(
      sectionTitle: json['sectionTitle'] as String,
      data: data,
      contents: contents,
    );
  }

  static List<GrammarContent> _parseContent(String data) {
    final List<GrammarContent> contents = [];
    final lines = data.split('\n');
    
    String currentType = '';
    String currentContent = '';
    
    for (var line in lines) {
      if (line.trim().isEmpty) continue;
      
      if (line.toLowerCase().contains('formulas:')) {
        if (currentContent.isNotEmpty) {
          contents.add(GrammarContent(
            type: currentType,
            content: currentContent.trim(),
          ));
        }
        currentType = 'formula';
        currentContent = '';
      } else if (line.toLowerCase().contains('signal words:')) {
        if (currentContent.isNotEmpty) {
          contents.add(GrammarContent(
            type: currentType,
            content: currentContent.trim(),
          ));
        }
        currentType = 'signal';
        currentContent = line.split(':')[1].trim();
      } else if (line.toLowerCase().contains('example:')) {
        if (currentContent.isNotEmpty) {
          contents.add(GrammarContent(
            type: currentType,
            content: currentContent.trim(),
          ));
        }
        currentType = 'example';
        currentContent = '';
      } else if (line.toLowerCase().contains('note:')) {
        if (currentContent.isNotEmpty) {
          contents.add(GrammarContent(
            type: currentType,
            content: currentContent.trim(),
          ));
        }
        currentType = 'note';
        currentContent = '';
      } else {
        if (currentType.isEmpty) {
          currentType = 'concept';
        }
        currentContent += line + '\n';
      }
    }
    
    if (currentContent.isNotEmpty) {
      contents.add(GrammarContent(
        type: currentType,
        content: currentContent.trim(),
      ));
    }
    
    return contents;
  }
}

class GrammarContent {
  final String type;
  final String content;

  GrammarContent({
    required this.type,
    required this.content,
  });
}
