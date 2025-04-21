import 'package:flutter/material.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Screen',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TestScreen(),
    );
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String? _selectedOption;

  // Hàm mở BottomSheet
  void _showOverviewBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return const OverviewBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar với tiêu đề "TEST 1"
      appBar: AppBar(
        title: const Text("TEST 1"),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _showOverviewBottomSheet,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            "Tổng quan & Nộp bài",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thời gian ở góc trên bên trái
              const Text(
                "9:55 PM",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Tiêu đề ở giữa
              Center(
                child: Text(
                  "TEST 1",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Progress bar và đồng hồ đếm ngược
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      "01:58:03",
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Phần ghi âm
              const Text(
                "Bản ghi âm",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(
                    Icons.play_circle_fill,
                    size: 32,
                    color: Colors.green,
                  ),
                  title: LinearProgressIndicator(
                    value: 0.7,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.green,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Hình ảnh (placeholder)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://via.placeholder.com/400x200.png?text=Hiking',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Câu hỏi trắc nghiệm "Question 1"
              const Text(
                "Question 1",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              OptionTile(
                option: "A",
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              OptionTile(
                option: "B",
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              OptionTile(
                option: "C",
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              OptionTile(
                option: "D",
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Nút "Tổng quan & Nộp bài"
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget cho lựa chọn trắc nghiệm với RadioListTile được bao bọc trong Card
class OptionTile extends StatelessWidget {
  final String option;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const OptionTile({
    Key? key,
    required this.option,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: RadioListTile<String>(
        title: Text(option),
        value: option,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}

/// Ví dụ widget BottomSheet (có thể giữ nguyên, không gây lỗi RenderFlex khi nội dung dài)
class OverviewBottomSheet extends StatelessWidget {
  const OverviewBottomSheet({Key? key}) : super(key: key);

  // Hàm tạo widget cho từng nút câu hỏi
  Widget _buildQuestionButton(BuildContext context, int number) {
    bool isSelected = (number == 9); // Làm nổi bật câu hỏi số 9
    return ElevatedButton(
      onPressed: () {
        // Xử lý chuyển đổi câu hỏi khi bấm vào nút (nếu cần)
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? Theme.of(context).primaryColor : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        fixedSize: const Size(48, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: Text(number.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // Sử dụng SingleChildScrollView để đảm bảo nội dung cuộn được nếu vượt quá chiều cao màn hình
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thanh drag nhỏ ở đầu BottomSheet
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  "Tổng quan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              // Thông tin tổng hợp số câu hỏi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: const [
                      Text("Tổng số câu"),
                      SizedBox(height: 4),
                      Text(
                        "200",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text("Đã trả lời"),
                      SizedBox(height: 4),
                      Text("0", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: const [
                      Text("Chưa trả lời"),
                      SizedBox(height: 4),
                      Text(
                        "200",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Phần 1: câu 1 đến 6
              const Text(
                "Phần 1",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(6, (index) {
                  int num = index + 1;
                  return _buildQuestionButton(context, num);
                }),
              ),
              const SizedBox(height: 16),
              // Phần 2: câu 7 đến 31
              const Text(
                "Phần 2",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(31 - 7 + 1, (index) {
                  int num = index + 7;
                  return _buildQuestionButton(context, num);
                }),
              ),
              const SizedBox(height: 16),
              // Phần 3: câu 32 đến 38
              const Text(
                "Phần 3",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(38 - 32 + 1, (index) {
                  int num = index + 32;
                  return _buildQuestionButton(context, num);
                }),
              ),
              const SizedBox(height: 24),
              // Nút "Nộp bài kiểm tra" ở dưới cùng của BottomSheet
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Xử lý logic nộp bài kiểm tra tại đây
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Nộp bài kiểm tra",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
