// import 'package:flutter/material.dart';
// import 'package:toeic/data/services/local/model/grammar_model.dart';
//
// class GrammarSectionWidget extends StatelessWidget {
//   final GrammarSection section;
//
//   const GrammarSectionWidget({super.key, required this.section});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           section.sectionTitle,
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         const SizedBox(height: 8),
//         ...section.items.map(
//           (item) => Card(
//             margin: const EdgeInsets.symmetric(vertical: 8),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item.name,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(height: 8),
//                   if (item.formulas.isNotEmpty) ...[
//                     Text("✔️ Formulas:"),
//                     for (var entry in item.formulas.entries)
//                       Text("• ${entry.key}: ${entry.value.join(', ')}"),
//                   ],
//                   if (item.signalWords.isNotEmpty) ...[
//                     const SizedBox(height: 6),
//                     Text("🪧 Signal words: ${item.signalWords.join(', ')}"),
//                   ],
//                   if (item.data.isNotEmpty) ...[Text(item.data)],
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
