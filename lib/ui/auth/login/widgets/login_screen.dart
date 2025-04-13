import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/services/api/model/login_request/login_request.dart';
import 'package:toeic/ui/auth/login/view_models/login_view_model.dart';

class LoginInScreen extends ConsumerStatefulWidget {
  const LoginInScreen({super.key});

  @override
  ConsumerState<LoginInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LoginInScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;

  void _handleLogin() {
    if (usernameController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      _showSnackbar(context, "Vui lòng nhập ầy đủ thông tin");
    } else {
      final request = LoginRequest(
        username: usernameController.text.trim(),
        password: passwordController.text,
      );

      ref.read(loginViewModelProvider.notifier).login(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {},
                    ),
                  ),
                  Text(
                    "Sign In",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Image.asset("images/cat.png", height: 80),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "TOEIC",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: " Test Pro",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Tài khoản",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      hintText: "Mật khẩu",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure =
                                !isObscure; // Thay đổi trạng thái hiển thị mật khẩu
                          });
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Quên mật khẩu",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 50,
                      ),
                    ),
                    child: const Text(
                      "Đăng Nhập",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("- Hoặc -", style: TextStyle(color: Colors.black54)),
                  SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      side: BorderSide(color: Colors.black54),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("images/cat.png", height: 20),
                        SizedBox(width: 10),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Không có tài khoản?"),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Đăng ký ngay",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (loginState.isLoading) _buildFullScreenLoading(),
          loginState.when(
            data: (data) {
              if (data.token.isNotEmpty) {
                Future.microtask(() {
                  _showCenteredDialog(
                    context,
                    "Đăng nhập thành công",
                    "Token: ${data.token}\nExpiry Time: ${data.expiryTime}",
                  );
                });
              }
              return const SizedBox.shrink();
            },
            error: (error, _) {
              Future.microtask(() {
                // _showCenteredDialog(context, "Lỗi", error.toString(), isError: true);
                _showSnackbar(context, error.toString(), isError: true);
              });
              return const SizedBox.shrink();
            },
            loading: () => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildFullScreenLoading() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  void _showCenteredDialog(
    BuildContext context,
    String title,
    String content, {
    bool isError = false,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                color: isError ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(content),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isError ? Colors.red : Colors.green,
                ),
                child: const Text("Đóng"),
              ),
            ],
          ),
    );
  }

  void _showSnackbar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: isError ? Colors.red : Colors.green),
      ),
      backgroundColor: isError ? Colors.black : Colors.blue,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
