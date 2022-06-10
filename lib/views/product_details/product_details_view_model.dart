import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/app.dart';
import 'package:harmis_opencart/models/cart.dart';
import 'package:harmis_opencart/models/message_master.dart';
import 'package:harmis_opencart/models/product_details.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/api_para.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/utils/custom_text_style.dart';
import 'package:harmis_opencart/views/login/login_view.dart';
import 'package:harmis_opencart/widgets/checkbox_custom.dart';
import 'package:harmis_opencart/widgets/radio_button/radio_button_custom.dart';

class ProductDetailsViewModel with ChangeNotifier {
  Services _service = new Services(new Service());
  LoginDetails loginDetails;
  AppPreferences appPreferences = new AppPreferences();
  String _languageCode = "";
  ProductDetail productDetail;
  List<dynamic> productImageList = new List();
  List<String> _selectedValue = new List();
  List<String> _parentOptionIds = new List();
  List<bool> _isMandatory = new List();
  List<bool> _selectedCheckboxValue = new List();
  List<String> _typeList = new List();
  bool isOptionsAvailable = false;
  bool isApiLoading = false, isDetailsAvailable = true;
  int cartQuantity = 0;

  void getProductDetails(String productId) async {
    _languageCode = await appPreferences.getLanguageCode();
    loginDetails = await appPreferences.getLoginDetails();
    isOptionsAvailable = false;
    isApiLoading = true;
    isDetailsAvailable = true;

    notifyListeners();
    ProductDetailMaster master =
        await _service.getProductDetails(getProductDetailsParams(productId));

    isApiLoading = false;
    if (master != null && master.success == 1 && master.result != null) {
      productDetail = master.result;
      if (productDetail.images != null && productDetail.images.length > 0) {
        productImageList.clear();
        for (ProductImage image in productDetail.images) {
          productImageList.add(NetworkImage(image.image));
        }
        if (productDetail.options != null && productDetail.options.length > 0)
          isOptionsAvailable = true;
      }
    } else {
      isDetailsAvailable = false;
    }

    notifyListeners();
  }

  String getProductDetailsParams(String productId) {
    var map = new Map<String, dynamic>();
    map[ApiParams.userId] = loginDetails != null ? loginDetails.userId : "";
    map[ApiParams.productId] = productId;
    map[ApiParams.referenceId] = "";
    map[ApiParams.sessionId] = "";
    map[ApiParams.languageCode] = _languageCode;
    if (Platform.isAndroid)
      map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
    else
      map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
    print("Parameter: " + json.encode(map));
    return json.encode(map);
  }

  List<Widget> getOptions() {
    _typeList.clear();
    //_selectedValue.clear();
    _parentOptionIds.clear();
    _isMandatory.clear();
    List<Widget> list = new List<Widget>();
    if (productDetail != null &&
        productDetail.options != null &&
        productDetail.options.length > 0) {
      for (int i = 0; i < productDetail.options.length; i++) {
        ProductOption productOption = productDetail.options[i];
        if (productOption.items != null && productOption.items.length > 0) {
          _typeList.add(productOption.type);
          _selectedValue.add("");
          _parentOptionIds.add(productOption.productOptionId);
          _isMandatory.add(productOption.isMandatory == "1" ? true : false);
          if (productOption.type == "0") {
            // Radio button
            list.addAll(getRadioButtons(productOption, i));
          } else if (productOption.type == "1") {
            // Checkbox
            if (_selectedCheckboxValue.length == 0) {
              for (ProductItem item in productOption.items) {
                _selectedCheckboxValue.add(false);
              }
            }
            list.addAll(getCheckboxes(productOption, i));
          } else if (productOption.type == "2") {
            list.addAll(getRadioButtons(productOption, i));
          }
          if (productDetail.options.length != (i + 1)) list.add(getDevider());
        }
      }
    }
    return list;
  }

  List<Widget> getRadioButtons(ProductOption productOption, int index) {
    void onRadioChanged(String value) {
      _selectedValue[index] = value;
      notifyListeners();
    }

    List<Widget> list = new List<Widget>();
    for (ProductItem productItem in productOption.items) {
      list.add(new Row(
        children: <Widget>[
          new RadioCustom(
              activeColor: CommonColors.primaryColor,
              value: productItem.optionId,
              groupValue: _selectedValue[index],
              onChanged: (String value) {
                onRadioChanged(value);
              }),
          new Text(
            productItem.value,
            style: TextStyle(
                letterSpacing: 0.5,
                color: Colors.black87,
                fontFamily: AppConstants.FONT_FAMILY,
                fontWeight: FontWeight.w500,
                fontSize: 13.0),
          ),
        ],
      ));
    }
    return list;
  }

  List<Widget> getCheckboxes(ProductOption productOption, int index) {
    void onCheckboxChanged(bool value, int i) {
      _selectedCheckboxValue[i] = value;
      notifyListeners();
    }

    List<Widget> list = new List<Widget>();
    for (int i = 0; i < productOption.items.length; i++) {
      ProductItem productItem = productOption.items[i];
      list.add(new Row(
        children: <Widget>[
          new CheckboxCustom(
              activeColor: CommonColors.primaryColor,
              value: _selectedCheckboxValue[i],
              //groupValue: _selectedValue[index],
              onChanged: (bool value) {
                onCheckboxChanged(value, i);
              }),
          new Text(productItem.value,
              style: TextStyle(
                  letterSpacing: 0.5,
                  color: Colors.black87,
                  fontFamily: AppConstants.FONT_FAMILY,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0)),
        ],
      ));
    }
    return list;
  }

  Widget getDevider() {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      color: Colors.black12,
      height: 1.0,
    );
  }

  List<Map<String, dynamic>> getOptionsArrayParams() {
    List<Map<String, dynamic>> productOptionList = new List();
    if (_typeList.length > 0) {
      for (int i = 0; i < _typeList.length; i++) {
        if (_typeList[i] == "0" || _typeList[i] == "2") {
          if (!CommonUtils.isEmpty(_selectedValue[i])) {
            var productOption = Map<String, dynamic>();
            productOption[ApiParams.type] = _typeList[i];
            productOption[ApiParams.productOptionId] = _parentOptionIds[i];

            List<Map<String, dynamic>> itemsArray = new List();
            var productItem = Map<String, dynamic>();
            productItem[ApiParams.optionId] = _selectedValue[i];
            itemsArray.add(productItem);
            productOption[ApiParams.items] = itemsArray;
            productOptionList.add(productOption);
          }
        } else if (_typeList[i] == "1") {
          var productOption = Map<String, dynamic>();
          productOption[ApiParams.type] = _typeList[i];
          productOption[ApiParams.productOptionId] = _parentOptionIds[i];

          List<Map<String, dynamic>> itemsArray = new List();
          var productItem = Map<String, dynamic>();

          for (int j = 0; j < _selectedCheckboxValue.length; j++) {
            if (_selectedCheckboxValue[j]) {
              productItem[ApiParams.optionId] =
                  productDetail.options[i].items[j].optionId;
              itemsArray.add(productItem);
            }
          }
          productOption[ApiParams.items] = itemsArray;
          productOptionList.add(productOption);
        }
      }
    }
    //print("Parameter: " + json.encode(productOptionList));
    return productOptionList;
  }

  bool checkValidation() {
    bool isValid = true;
    for (int i = 0; i < _typeList.length; i++) {
      if (_typeList[i] == "0" || _typeList[i] == "2") {
        if (CommonUtils.isEmpty(_selectedValue[i])) {
          isValid = false;
          break;
        }
      } else if (_typeList[i] == "1") {
        bool isSelect = false;
        for (bool isChecked in _selectedCheckboxValue) {
          if (isChecked) {
            isSelect = true;
            break;
          }
        }
        if (!isSelect) {
          isValid = false;
          break;
        }
      }
    }
    return isValid;
  }

  /*Update cart api*/
  void updateCart({Function success, context}) async {
    try {
      if (loginDetails != null) {
        CartMaster master = await _service.updateCart(productDetail.productId,
            "1", "1", loginDetails.userId, getOptionsArrayParams(), _languageCode);
        if (master != null) {
          cartQuantity = CommonUtils.isEmpty(master.totalItem)
              ? 0
              : int.parse(master.totalItem);
          success(master.message ?? "", cartQuantity.toString());
        }
        notifyListeners();
      } else {
        Navigator.of(context)
            .push(PageRouteBuilder(pageBuilder: (_, __, ___) => LoginView()))
            .then((value) async {
          var result = value as Map;
          if (result.containsKey(AppConstants.LOGIN_DETAILS)) {
            loginDetails = await appPreferences.getLoginDetails();
          }
        });
      }
    } catch (err) {
      print(err.toString());
      notifyListeners();
    }
  }

  void getCart() async {
    try {
      loginDetails = await appPreferences.getLoginDetails();
      _languageCode = await appPreferences.getLanguageCode();
      CartMaster master =
          await _service.getCart(loginDetails.userId, _languageCode);
      if (master != null && master.success == 1) {
        cartQuantity = CommonUtils.isEmpty(master.totalItem)
            ? 0
            : int.parse(master.totalItem);
      }
      notifyListeners();
    } catch (err) {}
  }

  void updateWishlist(BuildContext context, {Function success}) async {
    MessageMaster master = await _service.updateWishlist(
        getWishlistParams(productDetail.productId), onStartLoading: () {
      CommonUtils.showProgressDialog(context);
    }, onStopLoading: () {
      CommonUtils.hideProgressDialog(context);
    }, onNoInternet: () {
      CommonUtils.showToastMessage(S.of(context).noInternet);
    });
    if (master != null) {
      success(master.message);
    }
  }

  String getWishlistParams(String productId) {
    var map = new Map<String, dynamic>();
    map[ApiParams.userId] = loginDetails != null ? loginDetails.userId : "";
    map[ApiParams.productId] = productId;
    map[ApiParams.isFavourite] = "1";
    map[ApiParams.languageCode] = _languageCode;
    if (Platform.isAndroid)
      map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
    else
      map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
    print("Parameter: " + json.encode(map));
    return json.encode(map);
  }
}
