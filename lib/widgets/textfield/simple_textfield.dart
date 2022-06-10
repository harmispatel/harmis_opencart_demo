import 'package:flutter/material.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/constant.dart';

class SimpleTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) validator;
  final TextInputType keyboardType;

  SimpleTextField({this.hintText, this.controller, this.validator, this.keyboardType});

  FocusNode myFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType == null ? TextInputType.text : keyboardType,
      validator: validator == null
          ? (value) {
        return "";
      }
          : validator,
      style: TextStyle(
          letterSpacing: 0.1,
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
          color: Colors.black54,
          fontFamily: AppConstants.FONT_FAMILY),
      decoration: InputDecoration(
        labelText: hintText == null ? "" : hintText,
        labelStyle: TextStyle(
            fontSize: 16,
            fontFamily: AppConstants.FONT_FAMILY,
            color: myFocusNode.hasFocus ? CommonColors.primaryColor : Colors
                .black54
        ),
        hintStyle: TextStyle(
            letterSpacing: 0.1,
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
            color: Colors.black54,
            fontFamily: AppConstants.FONT_FAMILY),
      ),
    );
  }
}
