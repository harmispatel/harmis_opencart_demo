
import 'package:flutter/material.dart';
import 'package:harmis_opencart/app.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/cart.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:provider/provider.dart';

class AppModel with ChangeNotifier {

  Map<String, dynamic> appConfig;
  bool isLoading = true;
  String message;
  bool darkTheme = false;
  String locale = AppConstants.LANGUAGE_ENGLISH;
  static var scaffoldKey;
  LoginDetails loginDetails;
  String _languageCode = "";
  AppPreferences appPreferences = new AppPreferences();
  Services _service = Services(new Service());
  String CountNotice = "0";

  void changeLanguage() async {
    String locale = await appPreferences.getLanguageCode();
    if (CommonUtils.isEmpty(locale)) {
      appPreferences.setLanguageCode(this.locale);
      locale = this.locale;
    }
    this.locale = locale;
    notifyListeners();
  }

  void updateTheme(bool theme) {
    darkTheme = theme;
    notifyListeners();
  }

  void getCart() async {
    try {
      loginDetails = await appPreferences.getLoginDetails();
      _languageCode = await appPreferences.getLanguageCode();
      CartMaster master = await _service.getCart(loginDetails.userId, _languageCode);
      if (master != null && master.success == 1) {
        CountNotice = CommonUtils.isEmpty(master.totalItem) ? 0 : master.totalItem;
      }
      notifyListeners();
    } catch (err) {
    }
  }
}


class App {
  Map<String, dynamic> appConfig;
  App(this.appConfig);
}
