import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toeic/config/assets_url.dart';
import 'package:toeic/data/services/local/model/grammar_model.dart';
import 'package:toeic/ui/grammar/grammar_detail/widgets/grammar_section.dart';

class GrammarDetailScreen extends StatelessWidget {
  final String grammarId;

  const GrammarDetailScreen({super.key, required this.grammarId});

  Future<(String title, String description, List<GrammarSection> sections)>
  _loadGrammar(String grammarId) async {
    final jsonString = await rootBundle.loadString("${AssetsUrl.grammarUrl}/$grammarId.${AssetsUrl.grammarFileType}");
    final data = json.decode(jsonString);

    final String title = data['title'] ?? 'No title';
    final String description = data['description'] ?? '';
    final sections =
        (data['sections'] as List)
            .map((e) => GrammarSection.fromJson(e))
            .toList();

    return (title, description, sections);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadGrammar(grammarId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text("Grammar Detail")),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text("Grammar Detail")),
            body: Center(child: Text('Có lỗi xảy ra khi tải dữ liệu')),
          );
        }
        final (title, description, sections) = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: Text(title)),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(description, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              ...sections.map(
                (section) => GrammarSectionWidget(section: section),
              ),
            ],
          ),
        );
      },
    );
  }
}
