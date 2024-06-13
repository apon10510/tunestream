import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '$hintText is missing';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: obscureText,
    );
  }
}
