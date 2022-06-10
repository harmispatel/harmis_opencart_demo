import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/utils/local_images.dart';

class NoItemNotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                EdgeInsets.only(top: mediaQueryData.padding.top + 100.0)),
            Image.asset(
              LocalImages.noNotification,
              height: 200.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
            Text(
              S.of(context).notHaveNotification,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.5,
                  color: Colors.black54,
                  fontFamily: "Gotik"),
            ),
          ],
        ),
      ),
    );
  }
}