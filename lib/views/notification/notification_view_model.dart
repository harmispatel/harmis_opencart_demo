import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/notification.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';

class NotificationViewModel with ChangeNotifier {

  Services _service = Services(new Service());
  bool loggedIn = false;
  String message, _languageCode = "";
  bool loading = false;
  AppPreferences appPreferences = new AppPreferences();

  List<NotificationDetails> notificationList = new List();
  NotificationMaster notification;
  LoginDetails loginDetails;

  void getNotification() async {
    try {
      loginDetails = await appPreferences.getLoginDetails();
      _languageCode = await appPreferences.getLanguageCode();
      notificationList.clear();
      notification = await _service.getNotifications(offset: "0", languageCode: _languageCode, userId: loginDetails.userId);
      notificationList.addAll(notification.result);
      print(notificationList.length);
      loading = false;
      notifyListeners();
    } catch (err) {
      loading = false;
      message = err.toString();
      notifyListeners();
    }
  }
}
