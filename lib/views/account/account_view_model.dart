import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/user.dart';

class AccountViewModel with ChangeNotifier {

  AppPreferences appPreferences = new AppPreferences();
  LoginDetails loginDetails;

  void getUserDetails() async {
    try {
      loginDetails = await appPreferences.getLoginDetails();
      notifyListeners();
    } catch (err) {
      notifyListeners();
    }
  }

}
