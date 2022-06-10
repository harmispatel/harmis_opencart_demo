import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/categories.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';

class SubCategoryViewModel with ChangeNotifier {
  Services _service = Services(new Service());
  bool loggedIn = false;
  String message;
  bool loading = false;

  List<CategoriesDetails> categoryList = new List();
  AppPreferences appPreferences = new AppPreferences();
  bool imageLoad = true;
  int categoryStartLimit = 0, categoryTotalCount = 0;
  bool categoryIsApiLoading = false, isCategoryListAvailable = true;

  void getSubCategories(categoryId) async {
    try {
      isCategoryListAvailable = true;
      categoryIsApiLoading = true;
      if (categoryStartLimit == 0)
        imageLoad = true;
      notifyListeners();
      String languageCode = await appPreferences.getLanguageCode();
      CategoryMaster master = await _service.getSubCategories(
          languageCode: languageCode, categoryId: categoryId, offset: categoryStartLimit.toString());
      categoryIsApiLoading = false;
      if (categoryStartLimit == 0)
        imageLoad = false;
      print(master);

      if (master != null) {
        if (master.success == 1) {
          categoryTotalCount = master.total;
          if (master.result != null && master.result.length > 0) {
            if (categoryStartLimit == 0) categoryList.clear();
            categoryList.addAll(master.result);
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
      categoryIsApiLoading = false;
      message = err.toString();
      notifyListeners();
    }
  }

  void _showCategoryEmptyLayout() {
    if (categoryStartLimit == 0) {
      isCategoryListAvailable = false;
    }
  }
}
