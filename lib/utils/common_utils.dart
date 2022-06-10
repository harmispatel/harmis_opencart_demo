import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_just_toast/flutter_just_toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:harmis_opencart/widgets/custom_dialog/MyCustomDialog.dart';

import 'common_colors.dart';

class CommonUtils {
  static bool isShowing = false;

  static Widget getListItemProgressBar() {
    return new Center(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: new Center(
          child: new CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: CommonColors.primaryLightColor,
            valueColor:
                new AlwaysStoppedAnimation<Color>(CommonColors.primaryColor),
          ),
        ),
      ),
    );
  }

  static bool isEmpty(String string) {
    return string == null || string.length == 0;
  }

  static void showSnackBar(String message, globalKey) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    );
    globalKey.currentState.showSnackBar(snackBar);
  }

  static void showProgressDialog(BuildContext context) {
    MyCustomDialog changePasswordDialog = MyCustomDialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      //this right here
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: new Center(
          child: SpinKitWave(
            color: CommonColors.primaryColor,
            size: 40.0,
          ),
        ),
      ),
    );

    if (!isShowing) {
      showMyDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return changePasswordDialog;
          });
      isShowing = true;
    }
  }

  static void hideProgressDialog(BuildContext context) {
    if (isShowing) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      isShowing = false;
    }
  }

  static void showToastMessage(String message) {
    Toast.show(
        message: message,
        duration: Delay.SHORT,
        backgroundColor: Colors.black87,
        textColor: Colors.white);
  }
}
