import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'login_page.dart';
import 'welcome.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Diary',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const WelcomePage(), //  initial welcome page
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}