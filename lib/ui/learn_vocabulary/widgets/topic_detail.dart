import 'package:flutter/material.dart';

class TopicDetailScreen extends StatelessWidget {
  final String topic = "Warranties";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FBFF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          topic,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(Icons.emoji_events_outlined, color: Colors.orange),
          )
        ],
      ),
      body: Column(
        children: [
          // Accuracy Card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Text("Điểm số mới nhất được ghi lại",
                      style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 130,
                        child: CircularProgressIndicator(
                          value: 0.0,
                          strokeWidth: 10,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                      Text(
                        "0%\nChính xác",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFEDF0FF),
                            foregroundColor: Colors.black,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text("Học"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFEDF0FF),
                            foregroundColor: Colors.black,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text("Chơi game"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Stats
          _buildStatRow("Đã thuộc", 0, Colors.green, Icons.check_circle_outline),
          _buildStatRow("Chưa thuộc", 0, Colors.red, Icons.cancel_outlined),
          _buildStatRow("Chưa học", 12, Colors.orange, Icons.auto_stories, hasAction: true),
          _buildStatRow("Đánh dấu", 0, Colors.pink, Icons.bookmark_border),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, int count, Color color, IconData icon, {bool hasAction = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Text(count.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 12),
            Text("Trống", style: TextStyle(color: Colors.grey)),
            if (hasAction) ...[
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {},
                child: Text("Luyện tập >", style: TextStyle(color: Colors.blue)),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
