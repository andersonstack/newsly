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
        return Color(0xFF4A4A4A); // cinza escuro para descrições
      case GetColor.content:
        return Color(0xFF6A6A6A); // cinza médio para corpo do texto
      case GetColor.text:
        return Color(0xFF1C1C1C); // texto principal, quase preto
      case GetColor.tittle:
        return Color(0xFF000000); // títulos bem visíveis
      case GetColor.subtitle:
        return Color(0xFF0077CC); // azul para subtítulos, link-like
      case GetColor.emphasis:
        return Color(0xFFD7263D); // vermelho mais sóbrio para ênfases
      case GetColor.background:
        return Color(0xFFF4F4F4); // fundo claro padrão
      case GetColor.foreBackGround:
        return Color(0xFFFFFFFF); // branco para inputs e caixas
    }
  }
}
