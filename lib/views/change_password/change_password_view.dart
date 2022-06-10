import 'dart:async';

import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/views/account/profile_header_view.dart';
import 'package:harmis_opencart/views/change_password/change_password_view_model.dart';
import 'package:provider/provider.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final globalKey = GlobalKey<ScaffoldState>();

  String password, confirmPassword;

  final mPasswordController = TextEditingController();
  final mConfirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _changePassword(context) async {
      if (mPasswordController.text.isEmpty ||
          mConfirmPasswordController.text.isEmpty) {
        var snackBar = SnackBar(content: Text(S.of(context).pleaseInput));
        globalKey.currentState.showSnackBar(snackBar);
      } else if (mPasswordController.text.toString() != mConfirmPasswordController.text.toString()) {
        var snackBar = SnackBar(content: Text(S.of(context).passwordNotSame));
        globalKey.currentState.showSnackBar(snackBar);
      } else {
        Provider.of<ChangePasswordViewModel>(context).changePassword(
            password: mPasswordController.text.trim(),
            success: (user) {
              LoginMaster user1 = user as LoginMaster;
              print(user1);
              if (user1.success == 1) {
                var snackBar =
                SnackBar(content: Text(user1.message.toString()));
                globalKey.currentState.showSnackBar(snackBar);
                StartTime();
              } else {
                var snackBar =
                SnackBar(content: Text(user1.message.toString()));
                globalKey.currentState.showSnackBar(snackBar);
              }
            },
            fail: (message) {});
      }
    }

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop(false);
            },
            child: Icon(Icons.arrow_back)),
        elevation: 0.0,
        title: Text(
          S.of(context).changePassword,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.white,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: mPasswordController,
                  decoration: InputDecoration(
                      labelText: S.of(context).password,
                      hintText: S.of(context).password,
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  controller: mConfirmPasswordController,
                  decoration: InputDecoration(
                      labelText: S.of(context).confirmPassword,
                      hintText: S.of(context).confirmPassword,
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
                Padding(padding: EdgeInsets.only(top: 80.0)),
                InkWell(
                  onTap: () {
                    _changePassword(context);
                  },
                  child: Container(
                    height: 55.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black38, blurRadius: 15.0)
                        ],
                        gradient: LinearGradient(colors: <Color>[
                          CommonColors.primaryColor,
                          CommonColors.PrimaryDarkColor
                        ]),
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Center(
                      child: Text(
                        S.of(context).save,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.5,
                            letterSpacing: 1.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  StartTime() async {
    return Timer(Duration(milliseconds: 3000), (){Navigator.of(context).pop();});
  }
}
