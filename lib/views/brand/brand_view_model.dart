import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/brand.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';

class BrandViewModel with ChangeNotifier {

  Services _service = Services(new Service());

  int brandStartLimit = 0, brandTotalCount = 0;

  bool brandShimmer = true;

  bool brandIsApiLoading = false, isBrandListAvailable = true;

  bool loggedIn = false;
  String message;
  bool loading = false;

  BrandMaster brandMaster;

  List<BrandDetails> brandDetailsList = new List();

  AppPreferences appPreferences = new AppPreferences();

  void getBrand(String offset) async {
    try {
      brandIsApiLoading = true;
      if (brandStartLimit == 0) brandShimmer = true;
      notifyListeners();
      brandMaster = await _service.getBrads(brandStartLimit.toString());
      brandIsApiLoading = false;
      if (brandStartLimit == 0) brandShimmer = false;

      if (brandMaster != null) {
        if (brandMaster.success == 1) {
          brandTotalCount = brandMaster.total;
          if (brandMaster.result != null && brandMaster.result.length > 0) {
            if (brandStartLimit == 0) brandDetailsList.clear();
            brandDetailsList.addAll(brandMaster.result);
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
    if (brandStartLimit == 0) {
      isBrandListAvailable = false;
    }
  }
}
