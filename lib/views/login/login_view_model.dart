import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/api_para.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';

class LoginViewModel with ChangeNotifier {
  Services _service = Services(new Service());

  LoginMaster user;
  bool loggedIn = false;
  String message;
  bool loading = false;
  String deviceToken = "";
  String _languageCode = "";
  AppPreferences appPreferences = new AppPreferences();

  final GoogleSignIn googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  void login({username, password, Function success, Function fail}) async {
    try {
      loading = true;
      notifyListeners();
      deviceToken = await appPreferences.getDeviceToken();
      _languageCode = await appPreferences.getLanguageCode();
      user = await _service.login(
        username: username,
        password: password,
        deviceToken: deviceToken,
        languageCode: _languageCode
      );

      loggedIn = true;
      success(user);
      loading = false;
      notifyListeners();
    } catch (err) {
      loading = false;
      fail(err.toString());
//      print('login err $err');
      notifyListeners();
    }
  }

  void createUser(
      {username,
        firstName,
        lastName,
        email,
        password,
        phone,
        Function success,
        Function fail}) async {
    try {
      loading = true;
      notifyListeners();
      deviceToken = await appPreferences.getDeviceToken();
      _languageCode = await appPreferences.getLanguageCode();
      user = await _service.createUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phone,
        deviceToken: deviceToken,
        languageCode: _languageCode
      );
      loggedIn = true;
      success(user);
      loading = false;
      notifyListeners();
    } catch (err) {
      fail(err.toString());
      loading = false;
      notifyListeners();
    }
  }

  void googleLogin(BuildContext context) async {
    CommonUtils.showProgressDialog(context);
    googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount account) async {
      CommonUtils.hideProgressDialog(context);
      if (account != null) {
        // user logged
        socialLoginApi(context, account.id, account.email, account.displayName);
      } else {
        // user NOT logged
        print("User not logged");
      }
    });
    await googleSignIn.signIn();
  }

  void socialLoginApi(BuildContext context, String socialId, String email, String firstName) async {
    deviceToken = await appPreferences.getDeviceToken();
    _languageCode = await appPreferences.getLanguageCode();
    LoginMaster master = await _service.socialLogin(getSocialLoginParams(socialId, email, firstName),
        onStartLoading: (){
          CommonUtils.showProgressDialog(context);
        },
        onStopLoading: (){
          CommonUtils.hideProgressDialog(context);
        },
        onNoInternet: (){
          CommonUtils.showToastMessage(S.of(context).noInternet);
        });

    if (master != null) {
      if (master.success == 1 && master.result != null) {
        appPreferences.setLoginDetails(json.encode(master.result.toJson()));
        appPreferences.setLoggedIn(isLoggedIn: true);

        Navigator.pop(context, {
          AppConstants.LOGIN_DETAILS: "1",
        });
      } else {
        CommonUtils.showToastMessage(master.message?? "");
      }
    }
  }

  String getSocialLoginParams(String socialId, String email, String name) {
    var map = new Map<String, dynamic>();
    map[ApiParams.device] = Platform.isAndroid
        ? AppConstants.DEVICE_ACCESS_ANDROID
        : AppConstants.DEVICE_ACCESS_IOS;
    map[ApiParams.deviceToken] = deviceToken;
    map[ApiParams.email] = email;
    map[ApiParams.isSocial] = "1";
    map[ApiParams.isFacebook] = "0";
    map[ApiParams.socialId] = socialId;
    map[ApiParams.password] = "";
    map[ApiParams.firstName] = name;
    map[ApiParams.lastName] = "";
    map[ApiParams.sessionId] = "";
    map[ApiParams.languageCode] = _languageCode;

    print("Parameter: " + json.encode(map));
    return json.encode(map);
  }
}
