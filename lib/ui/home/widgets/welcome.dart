import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hình ảnh minh họa
            Image.asset(
              'images/cat.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            // Văn bản chính
            Text(
              'Đăng nhập để luyện thi hiệu quả hơn',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            // Văn bản mô tả
            Text(
              'Tham gia thi thử với đề thi sát 95% đề thi thật',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            // Nút Đăng ký / Đăng nhập
            ElevatedButton(
              onPressed: () {
                // Logic xử lý Đăng ký/Đăng nhập
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'Đăng ký / Đăng nhập',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            // Nút Bỏ qua
            TextButton(
              onPressed: () {
                // Logic xử lý Bỏ qua
              },
              child: Text(
                'Bỏ qua',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
