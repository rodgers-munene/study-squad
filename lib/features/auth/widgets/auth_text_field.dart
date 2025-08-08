import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label 
      ),
    );
  }
}
