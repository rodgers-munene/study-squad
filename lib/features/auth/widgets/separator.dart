import 'package:flutter/material.dart';
import 'package:studysquad/themes/themes.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width - 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: size * .42,
          height: 3,
          decoration: BoxDecoration(border: Border(bottom: BorderSide( color: AppColors.textSecondary))),
        ),
        Text("or", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, color: Colors.black),),
        Container(
          width: size * .45,
          height: 3,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.textSecondary))),
        ),

      ],
    );
  }
}
