import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toeic/config/assets_url.dart';
import 'package:toeic/routing/routes.dart';

class GrammarListScreen extends StatelessWidget {
  const GrammarListScreen({super.key});

  Future<List<Map<String, dynamic>>> _loadGrammarList() async {
    final data = await rootBundle.loadString('${AssetsUrl.grammarUrl}/grammar_list.json');
    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grammar')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadGrammarList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final list = snapshot.data!;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return ListTile(
                title: Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.grammarDetail,
                    arguments: item['id'],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
