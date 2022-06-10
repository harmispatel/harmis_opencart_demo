import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/utils/local_images.dart';

class NoDataAvailableView extends StatelessWidget {
  String image, message;


  NoDataAvailableView({this.image, this.message});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return  Container(
      width: 500.0,
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                EdgeInsets.only(top: mediaQueryData.padding.top + 50.0)),
            Image.asset(
              image?? LocalImages.ilustrasiCart,
              height: 300.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(
              message?? "No data found",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.5,
                  color: Colors.black26.withOpacity(0.2),
                  fontFamily: "Popins"),
            ),
          ],
        ),
      ),
    );
  }
}