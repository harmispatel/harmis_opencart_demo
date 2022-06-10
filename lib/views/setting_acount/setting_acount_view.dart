import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/views/setting_acount/setting_view.dart';

class SettingAcountView extends StatefulWidget {
  @override
  _SettingAcountViewState createState() => _SettingAcountViewState();
}

class _SettingAcountViewState extends State<SettingAcountView> {
  static var _txtCustomHead = TextStyle(
    color: Colors.black54,
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    fontFamily: "Gotik",
  );

  static var _txtCustomSub = TextStyle(
    color: Colors.black38,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Gotik",
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).settingAccount,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.white,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CommonColors.primaryColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SettingView(
                head: S.of(context).account,
                sub1: S.of(context).address,
                sub2: S.of(context).editProfile,
                sub3: S.of(context).changePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

