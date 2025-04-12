import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/models/sign_up_model.dart';
import 'package:toeic/ui/auth/sign_up/view_models/sign_up_view_model.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    dobController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signupState = ref.watch(signupViewModelProvider);

    ref.listen(signupViewModelProvider, (prev, next) {
      if (next is AsyncData && next.value != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đăng ký thành công!")),
        );
        print(next.value!.roles);
        // Navigator.pop(context); // Quay lại trang login chẳng hạn
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi: ${next.error}")),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset('images/cat.png', height: 100),
                const SizedBox(height: 10),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    children: [
                      TextSpan(text: 'TOEIC', style: TextStyle(color: Colors.blue)),
                      TextSpan(text: ' Test Pro'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField("Firstname", controller: firstNameController),
                _buildTextField("Lastname", controller: lastNameController),
                _buildTextField("DOB (Ngày sinh)", controller: dobController, isDateField: true),
                _buildTextField("City", controller: cityController),
                _buildTextField("Tên hiển thị", controller: usernameController),
                _buildTextField("Email (Tài khoản)", controller: emailController),
                _buildTextField("Mật khẩu", controller: passwordController, isPassword: true),
                _buildTextField("Nhập lại mật khẩu", controller: confirmPasswordController, isPassword: true),
                const SizedBox(height: 20),
                signupState.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Đăng kí", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                const SizedBox(height: 20),
                const Text("- Hoặc -", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Image.asset('images/cat.png', height: 24),
                  label: const Text("Sign in with Google", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Bạn đã có sẵn tài khoản? "),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text("Đăng nhập", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mật khẩu không khớp")),
      );
      return;
    }

    final request = SignupRequest(
      username: usernameController.text,
      password: passwordController.text,
      email: emailController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      dob: dobController.text,
      city: cityController.text,
    );

    ref.read(signupViewModelProvider.notifier).signup(request);
  }

  Widget _buildTextField(
      String hintText, {
        bool isPassword = false,
        bool isDateField = false,
        required TextEditingController controller,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: isPassword
              ? const Icon(Icons.lock)
              : (isDateField ? const Icon(Icons.calendar_today) : null),
        ),
        obscureText: isPassword,
        readOnly: isDateField,
        validator: (value) {
          if (value == null || value.isEmpty) return "Không được để trống";
          return null;
        },
        onTap: isDateField
            ? () async {
          DateTime initialDate = DateTime(2000);
          if (controller.text.isNotEmpty) {
            try {
              initialDate = DateTime.parse(controller.text);
            } catch (e) {
              // Nếu lỗi parse thì giữ nguyên initialDate mặc định
            }
          }

          DateTime? date = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (date != null) {
            controller.text = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
          }
        }
            : null,
      ),
    );
  }
}
