import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/local_images.dart';

class CallCenterView extends StatefulWidget {
  @override
  _CallCenterViewState createState() => _CallCenterViewState();
}

class _CallCenterViewState extends State<CallCenterView> {
  @override
  static var _txtCustomHead = TextStyle(
    color: Colors.black54,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    fontFamily: "Gotik",
  );

  static var _txtCustomSub = TextStyle(
    color: Colors.black26,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    fontFamily: "Gotik",
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).callCenter,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Colors.white,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CommonColors.primaryColor,
        elevation: 0.0,
      ),
      body: Container(
          color: Colors.white,
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                LocalImages.indonegirlcallcentersia,
                height: 175.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Text(
                  S.of(context).callCenter1,
                  style: _txtCustomHead,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
                child: Text(
                  S.of(context).callCenter2,
                  style: _txtCustomSub,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: InkWell(
                  onTap: () {
//                          Navigator.of(context).push(PageRouteBuilder(
//                              pageBuilder: (_, __, ___) => new chatItem()));
                  },
                  child: Center(
                    child: Container(
                      height: 50.0,
                      width: 280.0,
                      decoration: BoxDecoration(
                          color: CommonColors.primaryColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      child: Center(
                          child: Text(
                        S.of(context).callCenter3,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0),
                      )),
                    ),
                  ),
                ),
              )
            ],
          ))),
    );
  }
}
