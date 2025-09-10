// lib/main.dart
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/account_page.dart';
import 'pages/cart_page.dart';
import 'pages/home_page.dart';
import 'pages/change_password_page.dart';

void main() {
  runApp(const MyApp()); // ✅ const
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // ✅ const constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi E-Commerce',
      debugShowCheckedModeBanner: false, // ✅ hilangkan banner debug
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/account': (context) => const AccountPage(),
        '/cart': (context) => const CartPage(),
        '/home': (context) => const HomePage(), // ✅ sudah diperbaiki dari Homepage
        '/change_password': (context) => const ChangePasswordPage(),
      },
    );
  }
}
