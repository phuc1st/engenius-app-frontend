import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class GrammarScreen extends ConsumerStatefulWidget{
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GrammarScreenState();

}

class _GrammarScreenState extends ConsumerState<GrammarScreen> {


  final List<Map<String, dynamic>> grammarCategories = const [
    {
      'title': '1. Danh Từ',
      'subItems': [
        'Danh Từ là gì?',
        'Danh Từ Ghép (Compound Noun)',
        'Đại Từ (Pronouns)',
        'Phân biệt each other/another/other/others/the other/the others',
        'Either và Neither',
        'Cụm danh từ (Noun phrase)',
      ],
    },
    {
      'title': '2. Động Từ',
      'subItems': [],
    },
    {
      'title': '3. Tính Từ',
      'subItems': [],
    },
    {
      'title': '4. Trạng Từ',
      'subItems': [],
    },
    {
      'title': '5. Câu Đơn',
      'subItems': [],
    },
    {
      'title': '6. Câu Phức',
      'subItems': [],
    },
    {
      'title': '7. Mệnh Đề',
      'subItems': [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grammar'),
        leading: const BackButton(),
      ),
      body: ListView.builder(
        itemCount: grammarCategories.length,
        itemBuilder: (context, index) {
          final category = grammarCategories[index];
          return ExpansionTile(
            title: Text(
              category['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: List.generate(
              category['subItems'].length,
                  (subIndex) => ListTile(
                title: Text(category['subItems'][subIndex]),
                onTap: () {
                  // TODO: Handle navigation to detail screen
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
