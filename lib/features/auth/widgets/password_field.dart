import 'package:flutter/material.dart';
import 'package:studysquad/features/auth/widgets/auth_text_field.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool hidePassword;
  final String label;
  final VoidCallback toggleVisibility;
  

  const PasswordField({
    super.key,
    required this.controller,
    this.label = "Password",
    required this.hidePassword,
    required this.toggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AuthTextField(
          controller: controller,
          label: label,
          obscureText: hidePassword,
          validator: (value) => value!.isEmpty
              ? "This field is required"
              : value.length < 6
              ? "Password too short"
              : null,
        ),
        Positioned(
          right: 10,
          child: hidePassword
              ? IconButton(
                  onPressed: toggleVisibility,
                  icon: Icon(Icons.visibility_off_outlined),
                )
              : IconButton(
                  onPressed: toggleVisibility,
                  icon: Icon(Icons.visibility_outlined),
                ),
        ),
      ],
    );
  }
}
