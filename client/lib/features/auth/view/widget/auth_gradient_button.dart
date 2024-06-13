import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradiantButton extends StatelessWidget {
  final String text;
  final Function()? onClick;
  const AuthGradiantButton({super.key, this.onClick, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: LinearGradient(
            colors: [
              Pallete.gradient1,
              Pallete.gradient2,
            ],
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
