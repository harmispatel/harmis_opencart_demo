import 'package:flutter/material.dart';
import 'package:harmis_opencart/utils/constant.dart';

class DropdownTextView<T> extends StatelessWidget {
  final String text;

  DropdownTextView({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text == null ? "" : text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          letterSpacing: 0.1,
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
          color: Colors.black54,
          fontFamily: AppConstants.FONT_FAMILY),
    );
  }
}


