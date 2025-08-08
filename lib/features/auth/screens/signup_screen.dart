import 'package:flutter/material.dart';
import 'package:studysquad/features/auth/widgets/auth_background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(child: Center(child: Text("Welcome to signup screen"))),

    );
  }
}