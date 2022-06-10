import 'package:flutter/material.dart';

class TextFieldLables extends StatelessWidget {
  final String lableText;
  TextFieldLables(this.lableText);

  @override
  Widget build(BuildContext context) {
    return Text(
      lableText == null ? "" : lableText,
      style: TextStyle(
          letterSpacing: 0.1,
          fontWeight: FontWeight.w600,
          fontSize: 25.0,
          color: Colors.black54,
          fontFamily: "Gotik"),
    );
  }
}
