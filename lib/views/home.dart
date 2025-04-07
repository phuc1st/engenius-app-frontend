import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Migii TOEIC®"),
        backgroundColor: Colors.teal,
        actions: [IconButton(icon: Icon(Icons.settings), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue[100],
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Nhận voucher mở cơ hội 900+ TOEIC - Giảm 50%",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Image.asset("images/cat.png", height: 50),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Luyện tập",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: [
                _buildGridItem(Icons.headset, "Nghe Hiểu"),
                _buildGridItem(Icons.book, "Đọc Hiểu"),
                _buildGridItem(Icons.mic, "Luyện nói"),
                _buildGridItem(Icons.edit, "Viết"),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Luyện thi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: [
                _buildGridItem(Icons.computer, "Thi thử online"),
                _buildGridItem(Icons.description, "Thi thử"),
                _buildGridItem(Icons.card_membership, "Bao đỗ"),
                _buildGridItem(Icons.article, "Lý thuyết"),
                _buildGridItem(Icons.upgrade, "Nâng cấp"),
                _buildGridItem(Icons.settings, "Cài đặt"),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (value) => {
        setState(() {
        _selectedIndex = value;
        })
      },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Luyện tập"),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Lịch sử"),
          BottomNavigationBarItem(
              icon: Icon(Icons.workspace_premium), label: "Thành tích"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Cài đặt"),
        ],
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String title) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[200],
          ),
          padding: EdgeInsets.all(10),
          child: Icon(icon, size: 30, color: Colors.teal),
        ),
        SizedBox(height: 5),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }
}
