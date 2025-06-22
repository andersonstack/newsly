import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './colors.dart';

class MyTheme {
  ThemeData themeDefault() {
    return ThemeData(
      scaffoldBackgroundColor: GetColor.background.color,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: GetColor.text.color,
        onPrimary: GetColor.emphasis.color,
        secondary: GetColor.description.color,
        onSecondary: GetColor.description.color,
        error: GetColor.emphasis.color,
        onError: GetColor.subtitle.color,
        surface: GetColor.background.color,
        onSurface: GetColor.foreBackGround.color,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: GetColor.tittle.color,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w900,
        ),
        bodyLarge: TextStyle(
          color: GetColor.description.color,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w100,
        ),
        bodySmall: TextStyle(
          color: GetColor.content.color,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w100,
          fontSize: 10,
        ),
        labelLarge: TextStyle(
          color: GetColor.text.color,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
          decoration: TextDecoration.overline,
        ),
        labelMedium: TextStyle(
          color: GetColor.text.color,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w100,
          wordSpacing: 12,
        ),
        labelSmall: TextStyle(
          color: GetColor.text.color,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w100,
        ),
      ),
    );
  }

  ThemeData themeDark() {
    return ThemeData.dark();
  }
}
