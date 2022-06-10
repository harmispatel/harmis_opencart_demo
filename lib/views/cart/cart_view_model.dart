import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/cart.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';

class CartViewModel with ChangeNotifier {

  Services _service = Services(new Service());
  String message;
  bool loading = false, isDataAvailable = true;
  AppPreferences appPreferences = new AppPreferences();
  CartMaster cart;
  String _langageCode = "";

  List<CartDetails> cartList = new List();
  LoginDetails loginDetails;

  void getCart() async {
    try {
      loading = true;
      loginDetails = await appPreferences.getLoginDetails();
      _langageCode = await appPreferences.getLanguageCode();
      cartList.clear();
      notifyListeners();

      cart = await _service.getCart(loginDetails.userId, _langageCode);
      loading = false;
      if (cart != null && cart.products != null && cart.products.length > 0) {
        cartList.addAll(cart.products);
        isDataAvailable = true;
      } else {
        isDataAvailable = false;
      }
      notifyListeners();
    } catch (err) {
      loading = false;
      message = err.toString();
      notifyListeners();
    }
  }

  void deleteProductCart({productId, referenceId, Function success}) async {
    try {
      cartList.clear();
      _langageCode = await appPreferences.getLanguageCode();
      cart = await _service.deleteCarItem(productId, referenceId, loginDetails.userId, _langageCode);
      cartList.addAll(cart.products);
      print(cart);
      success(cart.totalItem);
      notifyListeners();
    } catch (err) {
      message = err.toString();
      notifyListeners();
    }
  }

  void updateCart(productId, quantity, action) async {
    try {
      cartList.clear();
      cart = await _service.updateCart(productId, quantity, action, loginDetails.userId, null, _langageCode);
      cartList.addAll(cart.products);
      print(cart);
      notifyListeners();
    } catch (err) {
      message = err.toString();
      notifyListeners();
    }
  }
}
