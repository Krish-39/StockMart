import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const StockMartApp());
}

class StockMartApp extends StatelessWidget {
  const StockMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StockMart',
      theme: AppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}