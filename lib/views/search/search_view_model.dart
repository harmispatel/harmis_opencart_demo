import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/cart.dart';
import 'package:harmis_opencart/models/product.dart';
import 'package:harmis_opencart/models/search.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/views/login/login_view.dart';

class SearchViewModel with ChangeNotifier {
  Services _service = new Services(new Service());
  bool imageLoad = true;

  List<ProductSingle> productList = new List();
  AppPreferences appSettings = new AppPreferences();
  int startLimit = 0, totalCount = 0;
  bool isApiLoading = false, isListAvailable = true;
  LoginDetails loginDetails;
  String _languageCode = "";

  ProductMaster searchMaster;
  String searchText = "";

  void getSearchProductListApi() async {
    isListAvailable = true;
    isApiLoading = true;
    if (startLimit == 0) {
      imageLoad = true;
      productList.clear();
    }
    notifyListeners();
    if (CommonUtils.isEmpty(_languageCode))
      _languageCode = await appSettings.getLanguageCode();
    searchMaster = await _service.searchProduct(searchText, startLimit, _languageCode);
    isApiLoading = false;
    if (startLimit == 0) imageLoad = false;
    if (searchMaster != null) {
      if (searchMaster.success == 1) {
        totalCount = searchMaster.total;
        if (searchMaster.result != null && searchMaster.result.length > 0) {
          if (startLimit == 0) productList.clear();
          productList.addAll(searchMaster.result);
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

  void _showEmptyLayout() {
    if (startLimit == 0) {
      isListAvailable = false;
      imageLoad = false;
    }
  }

  void updateCart(
      {productId, quantity, Function success, Function fail, context}) async {
    loginDetails = await appSettings.getLoginDetails();
    _languageCode = await appSettings.getLanguageCode();

    if (loginDetails != null) {
      CartMaster master = await _service
          .updateCart(productId, quantity, "1", loginDetails.userId, null, _languageCode,
              onStartLoading: () {
        CommonUtils.showProgressDialog(context);
      }, onStopLoading: () {
        CommonUtils.hideProgressDialog(context);
      }, onNoInternet: () {
        CommonUtils.showToastMessage(S.of(context).noInternet);
      });
      if (master != null && master.success == 1) {
        success(master.message, master.totalItem ?? "0");
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
  }
}
