import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/country_master.dart';
import 'package:harmis_opencart/models/message_master.dart';
import 'package:harmis_opencart/models/state_master.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/api_para.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';
import 'package:harmis_opencart/widgets/lables/drpdown_textview.dart';

class AddAddressViewModel with ChangeNotifier {
  Services _service = Services(new Service());
  String _languageCode = "";
  LoginDetails loginDetails;
  AppPreferences _appPreferences = new AppPreferences();
  bool isLoading = false;

  bool countryShimmer = false;
  List<CountryDetailsM> countryList = new List();
  List<DropdownMenuItem<CountryDetailsM>> countryDropdownMenuItems;
  CountryDetailsM selectedCountry;

  bool stateShimmer = false;
  List<StateDetails> stateList = new List();
  List<DropdownMenuItem<StateDetails>> stateDropdownMenuItems;
  StateDetails selectedState;
/*------------------Country list---------------------*/
  void getCountries() async {
    try {
      countryShimmer = true;
      notifyListeners();
      loginDetails = await _appPreferences.getLoginDetails();
      _languageCode = await _appPreferences.getLanguageCode();
      CountryMasterM master = await _service.getCountries();
      countryShimmer = false;
      if (master != null && master.success == 1 && master.result != null && master.result.length > 0) {
        countryList.addAll(master.result);
        countryDropdownMenuItems = buildDropdownMenuItems(countryList);
        selectedCountry = countryDropdownMenuItems[0].value;
        getStates(selectedCountry.countryId);
      } else {
        selectedCountry = null;
      }
      notifyListeners();
    } catch (err) {
      //  notifyListeners();
    }
  }

  List<DropdownMenuItem<CountryDetailsM>> buildDropdownMenuItems(
      List countries) {
    List<DropdownMenuItem<CountryDetailsM>> items = List();
    for (CountryDetailsM country in countries) {
      items.add(
        DropdownMenuItem(
          value: country,
          child: DropdownTextView(
            text: country.countryName,
          ),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(CountryDetailsM selectedCountry) {
    this.selectedCountry = selectedCountry;
    getStates(selectedCountry.countryId);
    notifyListeners();
  }

  /*------------------State list---------------------*/
  void getStates(String countryId) async {
    try {
      stateShimmer = true;
      stateList.clear();
      notifyListeners();
      StateMaster master = await _service.getStates(getStateListParams(countryId));
      stateShimmer = false;
      if (master != null && master.success == 1 && master.result != null && master.result.length > 0) {
        stateList.addAll(master.result);
        stateDropdownMenuItems = buildStateDropdownMenuItems(stateList);
        selectedState = stateDropdownMenuItems[0].value;
      } else {
        selectedState = null;
      }
      notifyListeners();
    } catch (err) {
      //  notifyListeners();
    }
  }

  List<DropdownMenuItem<StateDetails>> buildStateDropdownMenuItems(
      List states) {
    List<DropdownMenuItem<StateDetails>> items = List();
    for (StateDetails state in states) {
      items.add(
        DropdownMenuItem(
          value: state,
          child: DropdownTextView(
            text: state.stateName,
          ),
        ),
      );
    }
    return items;
  }

  onChangeStateDropdownItem(StateDetails selectedState) {
    this.selectedState = selectedState;
    notifyListeners();
  }

  String getStateListParams(String countryId) {
    var map = new Map<String, dynamic>();
    map[ApiParams.countryId] = countryId;
    map[ApiParams.languageCode] = _languageCode;
    print("Parameter: " + json.encode(map));
    return json.encode(map);
  }

  void addAddressApi({String firstname, String lastname, String phone, String address, String city, Function success, Function fail}) async {
    isLoading = true;
    notifyListeners();

    MessageMaster master = await _service.addAddress(getAddAddressParams(firstname, lastname, phone, address, city));
    isLoading = false;
    if (master != null && master.success == 1) {
      success(master.message);
    } else {
      fail(master.message);
    }
  }

  String getAddAddressParams(String firstname, String lastname, String phone, String address, String city) {
    var map = new Map<String, dynamic>();
    map[ApiParams.userId] = loginDetails != null ? loginDetails.userId : "";
    map[ApiParams.lat] = "22.70";
    map[ApiParams.long] = "72.50";
    map[ApiParams.isEdit] = "0";
    map[ApiParams.addressId] = "0";
    map[ApiParams.firstName] = firstname;
    map[ApiParams.lastName] = lastname;
    map[ApiParams.companyName] = loginDetails != null ? loginDetails.lastName : "";
    map[ApiParams.add1] = address;
    map[ApiParams.add2] = "delivery address";
    map[ApiParams.city] = city;
    map[ApiParams.postalCode] = "";
    map[ApiParams.countryId] = selectedCountry != null ? selectedCountry.countryId : "";
    map[ApiParams.stateId] = selectedState != null ? selectedState.stateId : "";
    map[ApiParams.languageCode] = _languageCode;

    var mapGoogleAddress = new Map<String, dynamic>();
    mapGoogleAddress[ApiParams.city] = "";
    mapGoogleAddress[ApiParams.state] = "";
    mapGoogleAddress[ApiParams.country] = "";
    mapGoogleAddress[ApiParams.placeName] = "";
    mapGoogleAddress[ApiParams.fullAddress] = "";
    mapGoogleAddress[ApiParams.placeId] = "";

    map[ApiParams.googleAddress] = mapGoogleAddress;

    print("Parameter: " + json.encode(map));
    return json.encode(map);
  }
}
