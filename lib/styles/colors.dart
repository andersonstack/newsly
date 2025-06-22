import 'package:flutter/material.dart';

enum GetColor {
  description,
  content,
  text,
  tittle,
  subtitle,
  emphasis,
  background,
  foreBackGround,
}

extension AppColor on GetColor {
  Color get color {
    switch (this) {
      case GetColor.description:
        return Color(0xFF000000);
      case GetColor.content:
        return Color.fromARGB(255, 94, 94, 94);
      case GetColor.text:
        return Color(0xFF000000);
      case GetColor.tittle:
        return Color.fromARGB(255, 23, 81, 129);
      case GetColor.subtitle:
        return Color(0xFFF9FF38);
      case GetColor.emphasis:
        return Color(0xFFF20C36);
      case GetColor.background:
        return Color.fromRGBO(255, 250, 250, 1);
      case GetColor.foreBackGround:
        return Color(0xFF590E0B);
    }
  }
}
