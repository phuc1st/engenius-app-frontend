import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image.asset('images/cat.png', height: 100),
            // Thay bằng logo của bạn
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: 'TOEIC', style: TextStyle(color: Colors.blue)),
                  TextSpan(text: ' Test Pro'),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildTextField("Tên hiển thị"),
            SizedBox(height: 10),
            _buildTextField("Email (Tài khoản)"),
            SizedBox(height: 10),
            _buildTextField("Mật khẩu", isPassword: true),
            SizedBox(height: 10),
            _buildTextField("Nhập lại mật khẩu", isPassword: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Đăng kí",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text("- Hoặc -", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {},
              icon: Image.asset('images/cat.png', height: 24),
              // Thay bằng icon Google
              label: Text("Sign in with Google",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Bạn đã có sẵn tài khoản? "),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, {bool isPassword = false}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: isPassword ? Icon(Icons.visibility_off) : null,
      ),
      obscureText: isPassword,
    );
  }
}
