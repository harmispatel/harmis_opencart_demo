import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/constant.dart';

///ButtonBlack class
///
///
class buttonBlackBottom extends StatelessWidget {

  String title;

  buttonBlackBottom({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(title,
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 0.2,
              fontFamily: AppConstants.FONT_FAMILY,
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: <Color>[CommonColors.primaryColor, CommonColors.PrimaryDarkColor])),
      ),
    );
  }
}