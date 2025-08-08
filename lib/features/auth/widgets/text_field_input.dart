import 'package:flutter/material.dart';
import 'package:studysquad/features/auth/widgets/auth_text_field.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const TextFieldInput({super.key, required this.controller,  this.label = "Email"});

  @override
  Widget build(BuildContext context) {
    return AuthTextField(controller: controller, label: label,
     validator: (value) => value!.isEmpty? "Email is required": null,);
  }
}
