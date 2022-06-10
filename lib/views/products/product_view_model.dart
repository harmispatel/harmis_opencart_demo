import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/cart.dart';
import 'package:harmis_opencart/models/product.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/api_para.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/views/login/login_view.dart';

class ProductViewModel with ChangeNotifier {
  Services _service = new Services(new Service());
  bool imageLoad = true;

  List<ProductSingle> productList = new List();
  String _languageCode = "";
  AppPreferences appSettings = new AppPreferences();
  int startLimit = 0, totalCount = 0;
  bool isApiLoading = false, isListAvailable = true;
  LoginDetails loginDetails;

  void getProductListApi(String catId) async {

    isListAvailable = true;
    isApiLoading = true;
    if (startLimit == 0) {
      imageLoad = true;
      productList.clear();
    }
    notifyListeners();

    loginDetails = await appSettings.getLoginDetails();
    _languageCode = await appSettings.getLanguageCode();
    ProductMaster master =
        await _service.getProductList(getProductsParams(catId));

    isApiLoading = false;
    if (startLimit == 0) imageLoad = false;

    if (master != null) {
      if (master.success == 1) {
        totalCount = master.total;
        if (master.result != null && master.result.length > 0) {
          productList.addAll(master.result);
        } else {
          _showEmptyLayout();
        }
      } else {
        _showEmptyLayout();
      }
    } else {
      _showEmptyLayout();
    }
    notifyListeners();
  }

  void getManufecturerProductListApi(String manufacturerId) async {

    isListAvailable = true;
    isApiLoading = true;
    if (startLimit == 0) imageLoad = true;
    notifyListeners();

    loginDetails = await appSettings.getLoginDetails();
    _languageCode = await appSettings.getLanguageCode();
    ProductMaster master =
    await _service.getManufecturerProductList(getManufeProductsParams(manufacturerId));

    isApiLoading = false;
    if (startLimit == 0) imageLoad = false;
    if (master != null) {
      if (master.success == 1) {
        totalCount = master.total;
        if (master.result != null && master.result.length > 0) {
          if (startLimit == 0) productList.clear();
          productList.addAll(master.result);
        } else {
          _showEmptyLayout();
        }
      } else {
        _showEmptyLayout();
      }
    } else {
      _showEmptyLayout();
    }
    notifyListeners();
  }

  String getProductsParams(String catId) {
    var map = new Map<String, dynamic>();
    map[ApiParams.userId] = loginDetails != null ? loginDetails.userId : "";
    map[ApiParams.isSubcategory] = "0";
    map[ApiParams.languageCode] = _languageCode;
    map[ApiParams.catId] = catId;
    if (Platform.isAndroid)
      map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
    else
      map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
    map[ApiParams.offset] = startLimit.toString();
    print("Parameter: " + json.encode(map));
    return json.encode(map);
  }

  String getManufeProductsParams(String manufacturerId) {
    var map = new Map<String, dynamic>();
    map[ApiParams.languageCode] = "es";//_languageCode;
    map[ApiParams.offset] = startLimit.toString();
    map[ApiParams.manufacturerId] = manufacturerId;
    print("Parameter: " + json.encode(map));
    return json.encode(map);
  }

  void _showEmptyLayout() {
    if (startLimit == 0) {
      isListAvailable = false;
      imageLoad = false;
    }
  }

  void updateCart({productId, quantity, Function success, Function fail, context}) async {
    print("fdhjfdhjf");
    loginDetails = await appSettings.getLoginDetails();
    _languageCode = await appSettings.getLanguageCode();

    try {
      if (loginDetails != null) {
        CartMaster master = await _service.updateCart(
            productId, quantity, "1", loginDetails.userId, null, _languageCode);
        if (master != null && master.success == 1) {
          success(master.message, master.totalItem?? "0");
        } else {
          fail(master.message);
        }
      } else {
        Navigator.of(context)
            .push(PageRouteBuilder(pageBuilder: (_, __, ___) => LoginView()))
            .then((value) async {
          var result = value as Map;
          if (result.containsKey(AppConstants.LOGIN_DETAILS)) {
            loginDetails = await appSettings.getLoginDetails();
          }
        });
      }
    } catch (err) {
      print(err.toString());
      notifyListeners();
    }
  }

}
