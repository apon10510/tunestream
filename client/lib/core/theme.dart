import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      enabledBorder: _border(Pallete.borderColor),
      focusedBorder: _border(Pallete.gradient1),
    ),
  );
}
