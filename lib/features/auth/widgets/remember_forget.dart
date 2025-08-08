import 'package:flutter/material.dart';

class RememberForget extends StatefulWidget {
  const RememberForget({super.key});

  @override
  State<RememberForget> createState() => _RememberForgetState();
}

class _RememberForgetState extends State<RememberForget> {

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
          visualDensity: VisualDensity.compact,
        ),
        Text(
          "Remember me",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        TextButton(
          onPressed: () => print("Pressed"),
          child: Text("Forgot Password?"),
        ),
      ],
    );
  }
}
