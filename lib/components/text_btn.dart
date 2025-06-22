import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TextBtn extends HookWidget {
  final VoidCallback function;
  final String text;
  final IconData? icon;

  const TextBtn({
    super.key,
    this.function = _defaultFunction,
    this.text = " ",
    this.icon,
  });

  static void _defaultFunction() {
    // ignore: avoid_print
    print("Não implementado");
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => function(),
      child: Row(children: [Text(text), if (icon != null) Icon(icon)]),
    );
  }
}
