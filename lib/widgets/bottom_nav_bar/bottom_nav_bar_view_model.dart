import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:harmis_opencart/app.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/views/login/login_view.dart';

class BottomNavBarViewModel extends ChangeNotifier {
  int currentIndex = 0;
  String _deviceToken = "";
  String _languageCode = "";
  LoginDetails loginDetails;
  AppPreferences appPreferences = new AppPreferences();

  void selectedTab(int index, BuildContext context) async {
    loginDetails = await appPreferences.getLoginDetails();
    if (index == 0 || loginDetails != null) {
      currentIndex = index;
      notifyListeners();
    } else {
      Navigator.of(context)
          .push(PageRouteBuilder(pageBuilder: (_, __, ___) => LoginView()))
          .then((value) async {
        var result = value as Map;
        if (result.containsKey(AppConstants.LOGIN_DETAILS)) {
          loginDetails = await appPreferences.getLoginDetails();
          currentIndex = index;
          notifyListeners();
        }
      });
    }
  }
}
