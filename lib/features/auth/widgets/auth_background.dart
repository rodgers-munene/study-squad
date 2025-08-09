import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB49EF4), Colors.white, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.7, 1.0]
          ),
        ),
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 80),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black
            ),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white
          ),
        padding: EdgeInsets.all(10),
        child: child,
      ),
    );
  }
}
