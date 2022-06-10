import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';

class ChangePasswordViewModel with ChangeNotifier {
  Services _service = Services(new Service());

  AppPreferences appPreferences = new AppPreferences();

  LoginDetails loginDetails;

  LoginMaster user;
  String message, _languageCode = "";

  void changePassword(
      {password, phone, Function success, Function fail}) async {
    try {
      loginDetails = await appPreferences.getLoginDetails();
      _languageCode = await appPreferences.getLanguageCode();
      user = await _service.changePassword(
        userId: loginDetails.userId,
        password: password,
        phone: loginDetails.phone,
        languageCode: _languageCode,
      );
      success(user);
    } catch (err) {
      fail(err.toString());
      notifyListeners();
    }
  }
}
