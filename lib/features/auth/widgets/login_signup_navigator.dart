import 'package:flutter/material.dart';

class LoginSignupNavigator extends StatelessWidget {
  final String txt1;
  final String txt2;
  final String route;

  const LoginSignupNavigator({
    super.key,
    required this.txt1,
    required this.txt2,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(txt1, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, route),
          child: Text(txt2, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: Colors.blue)),
        ),
      ],
    );
  }
}
