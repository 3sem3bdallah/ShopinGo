import 'package:flutter/material.dart';
import 'package:shoppingo/screens/welcome_screen.dart';

void main() {
  runApp(const ShoppingoApp());
}

class ShoppingoApp extends StatelessWidget {
  const ShoppingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShoppinGo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue.shade50,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2596be),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
