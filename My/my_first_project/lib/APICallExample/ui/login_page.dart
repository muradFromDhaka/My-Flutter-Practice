// pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:my_first_project/APICallExample/services/auth_service.dart';
import 'package:my_first_project/APICallExample/ui/product_list.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final AuthService authService = AuthService();

  bool isLoading = false;

  void LoginPage() async {
    setState(() => isLoading = true);

    bool success = await authService.login(
      usernameCtrl.text,
      passwordCtrl.text,
    );

    setState(() => isLoading = false);

    if (success) {
      // Navigate to ProductListPage after login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProductListPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed! Check credentials.')),
      );
    }
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameCtrl,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordCtrl,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: LoginPage, child: const Text('Login')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

