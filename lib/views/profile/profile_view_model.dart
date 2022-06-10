import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel with ChangeNotifier {
  Services _service = Services(new Service());
  bool loggedIn = false;
  String message;
  bool loading = false;
  String _languageCode = '';
  String _deviceToken = '';

  File _image;

  AppPreferences appPreferences = new AppPreferences();
  LoginDetails loginDetails;

  void getUserDetails() async {
    try {
      loginDetails = await appPreferences.getLoginDetails();
      _languageCode = await appPreferences.getLanguageCode();
      _deviceToken = await appPreferences.getDeviceToken();
      notifyListeners();
    } catch (err) {
      notifyListeners();
    }
  }

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera)
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    else
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;
    loginDetails.profileImage = image.path.toString();
    notifyListeners();
  }

  updateProfileApiCall(
      {String fname,
      String lname,
      String email,
      String phone,
      Function success}) async {
    loading = true;
    notifyListeners();

    await _service.updateProfile(
        fname: fname,
        lname: lname,
        email: email,
        phone: phone,
        imagePath: loginDetails.profileImage.toString(),
    userId: loginDetails.userId,
    languageCode: _languageCode,
    deviceToken: _deviceToken,
    success: (LoginMaster user){
      print("Api call over");
      if (user != null && user.success == 1) {
        print(user.message.toString());
        if (user.result != null) {
          loginDetails = user.result;
          appPreferences.setLoginDetails(json.encode(user.result.toJson()));
          print("user.mess");
          success(user.message);
        }
      }

      loggedIn = true;
      loading = false;
      notifyListeners();
    });


  }
}
