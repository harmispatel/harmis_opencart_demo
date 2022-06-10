import 'package:flutter/material.dart';
import 'package:harmis_opencart/utils/constant.dart';

var _txt = TextStyle(
  color: Colors.black,
  fontFamily: AppConstants.FONT_FAMILY,
);

class AccountCategoryView extends StatelessWidget {
  var _txtCategory = _txt.copyWith(
      fontSize: 14.5, color: Colors.black54, fontWeight: FontWeight.w500);

  @override
  String txt, image;
  GestureTapCallback tap;
  double padding;

  AccountCategoryView({this.txt, this.image, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: padding),
                  child: Image.asset(
                    image,
                    height: 25.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    txt,
                    style: _txtCategory,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
