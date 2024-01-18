import 'package:flutter/material.dart';
import 'package:signin_example/welcome/welcome.dart';
import 'signup/signup.dart';

void main() => runApp(const SignUpApp());

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => const SignUpScreen(),
        '/welcome': (context) => const WelcomeScreen(),
      },
    );
  }
}
