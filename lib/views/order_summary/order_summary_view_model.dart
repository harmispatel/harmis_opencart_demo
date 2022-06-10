import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/address.dart';
import 'package:harmis_opencart/models/cart.dart';
import 'package:harmis_opencart/models/coupon.dart';
import 'package:harmis_opencart/models/message_master.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/api_para.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';
import 'package:harmis_opencart/utils/constant.dart';

class OrderSummaryViewModel with ChangeNotifier {
  Services _services = new Services(new Service());
  bool isApiLoading = true, isDetailsAvailable = true;
  CartMaster cartMaster;
  AddressDetails addressDetails;
  LoginDetails _loginDetails;
  String _languageCode = "";
  AppPreferences _appPreferences = new AppPreferences();
  CouponDetails couponDetails;

  void setDetails(CartMaster cartMaster, AddressDetails addressDetails) async {
    isApiLoading = true;
    notifyListeners();
    _loginDetails = await _appPreferences.getLoginDetails();
    _languageCode = await _appPreferences.getLanguageCode();
    this.cartMaster = cartMaster;
    this.addressDetails = addressDetails;
    isApiLoading = false;
    notifyListeners();
  }

  void applyCouponCode(String couponCode, {Function onMessage}) async {
    CouponMaster master =
        await _services.applyCouponCode(getCouponCodeParams(couponCode));
    if (master != null) {
      if (master.success == 1 && master.result != null) {
        couponDetails = master.result;
        cartMaster.discountValue = couponDetails.discountValue;
        cartMaster.total = couponDetails.updatedTotal;
        notifyListeners();
      }
      if (master.message != null) onMessage(master.message);
    }
  }

  String getCouponCodeParams(String couponCode) {
    var map = new Map<String, dynamic>();
    map[ApiParams.userId] = _loginDetails != null ? _loginDetails.userId : "";
    map[ApiParams.languageCode] = _languageCode;
    map[ApiParams.couponCode] = couponCode;
    map[ApiParams.total] = cartMaster != null ? cartMaster.total : "";

    print("Parameter: " + json.encode(map));
    return json.encode(map);
  }

  void placeOrder(String comments, {Function onMessage, Function onSuccess}) async {
    MessageMaster master =
        await _services.placeOrder(getPlaceOrderParams(comments));
    if (master != null) {

        if (master.success == 1) {
          onSuccess(master.message);
        } else {
          onMessage(master.message);
        }

    }
  }

  String getPlaceOrderParams(String comments) {
    var map = new Map<String, dynamic>();
    map[ApiParams.userId] = _loginDetails != null ? _loginDetails.userId : "";
    map[ApiParams.sessionId] = "";
    map[ApiParams.device] = Platform.isAndroid
        ? AppConstants.DEVICE_ACCESS_ANDROID
        : AppConstants.DEVICE_ACCESS_IOS;
    map[ApiParams.addressId] = addressDetails?.addressId ?? "";
    map[ApiParams.paymentaddressId] = addressDetails?.addressId ?? "";
    map[ApiParams.comments] = comments;
    map[ApiParams.paymentType] = "0";
    map[ApiParams.payfortId] = "";
    map[ApiParams.languageCode] = _languageCode;
    map[ApiParams.coupon] = couponDetails != null
        ? couponDetails.toJson()
        : "{}";
    map[ApiParams.shippingCharge] = cartMaster.shippingCharge.toString();

    print("Parameter: " + json.encode(map));
    return json.encode(map);
  }
}
