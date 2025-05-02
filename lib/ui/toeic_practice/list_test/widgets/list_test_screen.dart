import 'package:flutter/material.dart';
import 'package:toeic/routing/routes.dart';

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
          onPressed: () => Navigator.pushNamed(context, Routes.home),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.workspace_premium_outlined,
              color: Colors.amber,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: tests.length,
        itemBuilder: (context, index) {
          final testNumber = tests[index];
          final isTakingTest = testNumber == 1 || testNumber == 3;
          final isNew = testNumber == 2 || testNumber == 4;

          return testItem(
            testNumber: testNumber,
            isTakingTest: isTakingTest,
            isNew: isNew,
            onTap: onTestItemTap,
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget testItem({
    required int testNumber,
    required bool isTakingTest,
    bool isNew = false,
    double? score,
    required void Function(int) onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(testNumber),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 0.2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.auto_stories,
                    size: 28,
                    color: Colors.lightBlueAccent,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TEST $testNumber",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (isTakingTest)
                          Row(
                            children: [
                              const Icon(
                                Icons.wifi_tethering_rounded,
                                size: 20,
                                color: Colors.lightBlueAccent,
                              ),
                              const Text(
                                "Bài kiểm tra đang diễn ra...",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  if (isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.auto_awesome_sharp,
                            color: Colors.blueAccent,
                            size: 16,
                          ),
                          const Text(
                            " Mới",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsetsGeometry.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Điểm của bạn: ${score ?? "Không có dữ liệu"}",
                      style: TextStyle(fontSize: 13),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFAA84F3),
                        borderRadius: BorderRadius.circular(19.5),
                      ),
                      child: const Icon(
                        Icons.double_arrow,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTestItemTap(int testNumber) {
    print("Tap on: $testNumber");
  }
}
