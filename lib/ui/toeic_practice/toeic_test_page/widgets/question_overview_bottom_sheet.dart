import 'package:flutter/material.dart';

class QuestionOverviewBottomSheet extends StatelessWidget {
  final int totalQuestions;
  final Set<int> answeredQuestions;
  final void Function(int) onQuestionTap;
  final VoidCallback onSubmit;

  const QuestionOverviewBottomSheet({
    super.key,
    required this.totalQuestions,
    required this.answeredQuestions,
    required this.onQuestionTap,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 80), // chừa chỗ cho nút
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.grid_view_rounded, color: Colors.black54),
                          SizedBox(width: 8),
                          Text(
                            'Tổng quan',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Tabs
                  DefaultTabController(
                    length: 3,
                    child: Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            // isScrollable: true,
                            labelColor: Colors.blue,
                            unselectedLabelColor: Colors.grey,
                            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                            tabs: [
                              Tab(text: 'Câu hỏi ($totalQuestions)'),
                              Tab(text: 'Đã trả lời (${answeredQuestions.length})'),
                              Tab(text: 'Chưa trả lời (${totalQuestions - answeredQuestions.length})'),
                            ],
                            labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: List.generate(3, (index) {
                                final List<int> filteredQuestions = List.generate(
                                  totalQuestions,
                                      (i) => i + 1,
                                ).where((q) {
                                  if (index == 1) return answeredQuestions.contains(q);
                                  if (index == 2) return !answeredQuestions.contains(q);
                                  return true;
                                }).toList();
                      
                                return SingleChildScrollView(
                                  controller: scrollController,
                                  padding: const EdgeInsets.only(top: 16),
                                  child: _buildGroupedQuestions(filteredQuestions),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Positioned Button on top of bottom sheet
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  elevation: 3,
                  side: const BorderSide(color: Colors.blue),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Nộp bài kiểm tra',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        );
      },
    );
  }


  Widget _buildGroupedQuestions(List<int> questions) {
    final Map<String, List<int>> parts = {
      'Part 1': [],
      'Part 2': [],
      'Part 3': [],
    };

    for (var q in questions) {
      if (q <= 6) {
        parts['Part 1']!.add(q);
      } else if (q <= 31) {
        parts['Part 2']!.add(q);
      } else {
        parts['Part 3']!.add(q);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: parts.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: entry.value.map((q) {
                final isAnswered = answeredQuestions.contains(q);
                return GestureDetector(
                  onTap: () => onQuestionTap(q),
                  child: Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isAnswered ? Colors.green : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: q == 9 ? Colors.blue.shade50 : null, // giả lập "đang chọn"
                    ),
                    child: Text(
                      '$q',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isAnswered ? Colors.green : Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }
}
