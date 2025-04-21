import 'package:flutter/material.dart';

class FullTestScreen extends StatelessWidget {
  const FullTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tests = List.generate(5, (index) => index + 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text("FULL TEST"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.workspace_premium_outlined, color: Colors.amber),
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: tests.length,
        itemBuilder: (context, index) {
          final testNumber = tests[index];
          final isOngoing = testNumber == 1 || testNumber == 3;
          final isNew = testNumber == 2 || testNumber == 4;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/cat.png',
                    width: 28,
                    height: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("TEST $testNumber",
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        if (isOngoing)
                          const Text(
                            "🗣️ Bài kiểm tra đang diễn ra...",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 13,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (isNew)
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "+ Mới",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                ],
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Điểm của bạn: Không có dữ liệu",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              trailing: const Icon(
                Icons.double_arrow_rounded,
                color: Colors.deepPurple,
                size: 28,
              ),
              onTap: () {
                // Xử lý khi nhấn vào test
              },
            ),
          );
        },
      ),
      backgroundColor: const Color(0xFFF5F6FA),
    );
  }
}
