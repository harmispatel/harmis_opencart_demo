import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/cart.dart';
import 'package:harmis_opencart/models/favorites.dart';
import 'package:harmis_opencart/models/message_master.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/api_para.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';

class FavoriteViewModel with ChangeNotifier {
  Services _service = Services(new Service());

  int wishListStartLimit = 0, wishListTotalCount = 0;

  bool favoriteShimmer = true;

  bool brandIsApiLoading = false, isBrandListAvailable = true;
  String _languageCode = "";

  FavoritesMaster favoritesMaster;

  List<FavoritesDetails> favoritesDetailsList = new List();
  LoginDetails loginDetails;

  AppPreferences appPreferences = new AppPreferences();

  void getWishList() async {
    try {
      brandIsApiLoading = true;
      if (wishListStartLimit == 0) {
        favoriteShimmer = true;
        favoritesDetailsList.clear();
      }
      notifyListeners();

      loginDetails = await appPreferences.getLoginDetails();
      _languageCode = await appPreferences.getLanguageCode();
      favoritesMaster = await _service.getWishList(_languageCode.toString(),
          wishListStartLimit.toString(), loginDetails.userId.toString());

      brandIsApiLoading = false;
      if (wishListStartLimit == 0) favoriteShimmer = false;

      if (favoritesMaster != null) {
        if (favoritesMaster.success == 1) {
          wishListTotalCount = int.parse(favoritesMaster.total);
          if (favoritesMaster.result != null &&
              favoritesMaster.result.length > 0) {
            favoritesDetailsList.addAll(favoritesMaster.result);
          } else {
            _showCategoryEmptyLayout();
          }
        } else {
          _showCategoryEmptyLayout();
        }
      } else {
        _showCategoryEmptyLayout();
      }
      notifyListeners();
    } catch (err) {
      brandIsApiLoading = false;
      notifyListeners();
    }
  }

  void _showCategoryEmptyLayout() {
    if (wishListStartLimit == 0) {
      isBrandListAvailable = false;
    }
  }

  void updateWishlist(BuildContext context, String productId, int position,
      {Function success}) async {
    MessageMaster master = await _service
        .updateWishlist(getWishlistParams(productId),
       onStartLoading: () {
      CommonUtils.showProgressDialog(context);
    }, onStopLoading: () {
      CommonUtils.hideProgressDialog(context);
    }, onNoInternet: () {
      CommonUtils.showToastMessage(S.of(context).noInternet);
    });
    if (master != null) {
      if (master.success == 1) {
        wishListStartLimit = 0;
        wishListTotalCount = 0;
        getWishList();
      }
      success(master.message);
    }
  }

  String getWishlistParams(String productId) {
    var map = new Map<String, dynamic>();
    map[ApiParams.userId] = loginDetails != null ? loginDetails.userId : "";
    map[ApiParams.productId] = productId;
    map[ApiParams.isFavourite] = "0";
    map[ApiParams.languageCode] = _languageCode;
    if (Platform.isAndroid)
      map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
    else
      map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
    print("Parameter: " + json.encode(map));
    return json.encode(map);
  }

  void updateCart({productId, quantity, Function success, Function fail, context}) async {
    CartMaster master = await _service.updateCart(
        productId, quantity, "1", loginDetails?.userId?? "", null, _languageCode, onStartLoading: () {
      CommonUtils.showProgressDialog(context);
    }, onStopLoading: () {
      CommonUtils.hideProgressDialog(context);
    }, onNoInternet: () {
      CommonUtils.showToastMessage(S.of(context).noInternet);
    });
    if (master != null && master.success == 1) {
      success(master.message);
    } else {
      fail(master.message);
    }
  }
}
