import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/address.dart';
import 'package:harmis_opencart/models/delete_address.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';

class AddressListViewModel with ChangeNotifier {

  Services _service = Services(new Service());
  bool loggedIn = false;
  String message;
  AppPreferences appPreferences = new AppPreferences();
  AppPreferences appSettings = new AppPreferences();
  AddressMaster address;
  DeleteAddressMaster deleteAddressMaster;
  String _languageCode = "";
  AddressDetails selectedAddress;


  bool isApiLoading = false, isDetailsAvailable = true;

  List<AddressDetails> addressList = new List();

  LoginDetails loginDetails;

  void getAddressList() async {
    try {
      isApiLoading = true;
      addressList.clear();
      selectedAddress = null;
      notifyListeners();

      loginDetails = await appPreferences.getLoginDetails();
      _languageCode = await appPreferences.getLanguageCode();
      address = await _service.getAddress(loginDetails.userId, _languageCode);

      isApiLoading = false;
      if (address != null &&
          address.result != null &&
          address.result.length > 0) {
        isDetailsAvailable = true;
        addressList.addAll(address.result);
      } else {
        isDetailsAvailable = false;
      }

      print(address);
      notifyListeners();
    } catch (err) {
      message = err.toString();
      notifyListeners();
    }
  }

  void selectAddress(int position) {
    try {
      for (int i = 0; i < addressList.length; i++) {
        addressList[i].isSelected = false;
      }
      selectedAddress = addressList[position];
      addressList[position].isSelected = true;
      notifyListeners();
    } catch (e) {}
  }

  void deleteAddress(String addressId) async {
    try {
      loginDetails = await appPreferences.getLoginDetails();
      _languageCode = await appSettings.getLanguageCode();

      deleteAddressMaster =
          await _service.deleteAddress(loginDetails.userId, addressId, _languageCode);

      if (deleteAddressMaster.success == 1) {
        getAddressList();
      } else {}
      notifyListeners();
    } catch (err) {
      message = err.toString();
      notifyListeners();
    }
  }

  bool checkValidation() {
    if (selectedAddress != null) {
      return true;
    } else {
      return false;
    }
  }
}
