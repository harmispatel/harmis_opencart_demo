import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/api_para.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/widgets/bottom_nav_bar/bottom_nav_bar.dart';

class SplashViewModel with ChangeNotifier {
  String _deviceToken = "";
  String _languageCode = "";
  AppPreferences appPreferences = new AppPreferences();
  LoginDetails loginDetails;
  Services _service = Services(new Service());

  startTimer(BuildContext context) {
    return new Timer(Duration(milliseconds: 2000), () async {
      _languageCode = await appPreferences.getLanguageCode();
      _deviceToken = await appPreferences.getDeviceToken();
      loginDetails = await appPreferences.getLoginDetails();
      if (loginDetails != null && !CommonUtils.isEmpty(loginDetails.userId)) {
        userDetailsApiCall(context);
      } else {
        redirectToHome(context);
      }
    });
  }

  void redirectToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
        PageRouteBuilder(pageBuilder: (_, __, ___) => bottomNavigationBar()));
  }

  userDetailsApiCall(BuildContext context) async {
    LoginMaster master = await _service.userDetails(getUserDetailsParams());
    if (master != null) {
      if (master.success == 1) {
        appPreferences
            .setLoginDetails(json.encode(master.result.toJson()));
      }
    }
    redirectToHome(context);
  }

  String getUserDetailsParams() {
    var map = new Map<String, dynamic>();
    map[ApiParams.userId] = loginDetails.userId;
    map[ApiParams.deviceToken] = _deviceToken;
    map[ApiParams.sessionId] = "";
    map[ApiParams.languageCode] = _languageCode;
    if (Platform.isAndroid)
      map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
    else
      map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
    print("Parameter: " + json.encode(map));
    return json.encode(map);
  }
}
