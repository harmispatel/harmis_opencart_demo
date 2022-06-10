
import 'package:flutter/material.dart';
import 'package:harmis_opencart/utils/common_colors.dart';

class RCPrimaryButton extends StatelessWidget {

  final Function onPressed;
  final String btnText;


  RCPrimaryButton({this.onPressed, this.btnText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55.0,
        width: 300.0,
        decoration: BoxDecoration(
            color: CommonColors.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16.5,
                letterSpacing: 1.0),
          ),
        ),
      ),
    );
  }
}
