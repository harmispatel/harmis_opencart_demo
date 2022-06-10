import 'package:flutter/material.dart';
import 'package:harmis_opencart/utils/custom_text_style.dart';

class BottomsheetDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Container(
            height: 1500.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 20.0)),
                Center(
                    child: Text(
                      "Description",
                      style: CustomTextStyle.subHeaderCustomStyle,
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                  child: Text(
                      "Long Description",      style: CustomTextStyle.detailText),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Specifications",
                    style: TextStyle(
                        fontFamily: "Gotik",
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                        color: Colors.black,
                        letterSpacing: 0.3,
                        wordSpacing: 0.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Text(
                    "Small description",
                    style: CustomTextStyle.detailText,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
