import 'package:flutter/material.dart';
import 'package:shoppingo/screens/home_screen.dart';
import '../utils/user_data.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = "";

  void signIn() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (!UserData.users.containsKey(email) ||
        UserData.users[email]?['password'] != password) {
      setState(() {
        errorMessage = "Invalid email or password!";
      });
      return;
    }

    String name = UserData.users[email]?['name'] ?? "User";
    UserData.username = name; // <-- هذا السطر الجديد

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(name: name)),  
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signIn,
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
