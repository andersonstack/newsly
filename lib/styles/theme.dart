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
        surface: GetColor.foreBackGround.color,
        onSurface: GetColor.text.color,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: GetColor.tittle.color,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: GetColor.description.color,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: GetColor.content.color,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
        labelLarge: TextStyle(
          color: GetColor.text.color,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
        labelMedium: TextStyle(
          color: GetColor.text.color,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        labelSmall: TextStyle(
          color: GetColor.text.color,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w300,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: GetColor.tittle.color,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 14,
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        filled: true,
        fillColor: GetColor.foreBackGround.color,
        iconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: GetColor.subtitle.color, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return Color(0xFF0077CC);
            } else {
              return Color(0xFF0077CC);
            }
          }),
          foregroundColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return GetColor.foreBackGround.color;
            } else {
              return GetColor.foreBackGround.color;
            }
          }),
        ), //Color(0xFF0077CC)
      ),
    );
  }

  ThemeData themeDark() {
    return ThemeData.dark();
  }
}
