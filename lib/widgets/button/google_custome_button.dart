import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/utils/local_images.dart';

///buttonCustomGoogle class


class buttonCustomGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        alignment: FractionalOffset.center,
        height: 49.0,
        width: 500.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.0)],
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(LocalImages.google_logo,
              height: 25.0,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            Text(S.of(context).loginGoogle,
              style: TextStyle(
                  color: Colors.black26,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Sans'),
            )
          ],
        ),
      ),
    );
  }
}