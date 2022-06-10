import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/banner.dart';
import 'package:harmis_opencart/models/best_seller.dart';
import 'package:harmis_opencart/models/categories.dart';
import 'package:harmis_opencart/models/product.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';

class HomeViewModel with ChangeNotifier {
  Services _service = Services(new Service());
  bool bestSellerShimmer = true;
  bool categoryShimmer = true;
  bool recomandedShimmer = true;

  List<dynamic> bannerImageList = new List();
  List<BannerDetails> banners;
  List<CategoriesDetails> categoryList = new List();
  List<BestSellerDetails> bestSellers = new List();
  List<ProductSingle> recomandedProductList = new List();

  AppPreferences appSettings = new AppPreferences();

  String _languageCode = "";

  ProductMaster recomandedProducts;

  AppPreferences appPreferences = new AppPreferences();

  int categoryStartLimit = 0, categoryTotalCount = 0;

  bool categoryIsApiLoading = false, isCategoryListAvailable = true;

  void getBanners() async {
    try {
      bannerImageList.clear();
      _languageCode = await appSettings.getLanguageCode();
      banners = await _service.getBanners(_languageCode);
      for (BannerDetails banner in banners) {
        bannerImageList.add(NetworkImage(banner.image));
      }
      notifyListeners();
    } catch (err) {
      notifyListeners();
    }
  }

  void getCategories() async {
    try {
      categoryIsApiLoading = true;
      if (categoryStartLimit == 0) {
        categoryShimmer = true;
        categoryList.clear();
      }
      notifyListeners();
      String languageCode = await appPreferences.getLanguageCode();
      CategoryMaster master =
          await _service.getCategories(languageCode, categoryStartLimit);
      categoryIsApiLoading = false;
      if (categoryStartLimit == 0) categoryShimmer = false;
      print(master);

      if (master != null) {
        if (master.success == 1) {
          categoryTotalCount = master.total;
          if (master.result != null && master.result.length > 0) {
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
      notifyListeners();
    }
  }

  void _showCategoryEmptyLayout() {
    if (categoryStartLimit == 0) {
      isCategoryListAvailable = false;
    }
  }

  void getBestSellers() async {
    try {
      bestSellerShimmer = true;
      bestSellers.clear();
      notifyListeners();
      _languageCode = await appSettings.getLanguageCode();
      bestSellers = await _service.getBestSellers(_languageCode);
      bestSellerShimmer = false;
      print(bestSellers);
      notifyListeners();
    } catch (err) {
      notifyListeners();
    }
  }

  void recomandedProductAPI() async {
    try {
      _languageCode = await appSettings.getLanguageCode();
      recomandedShimmer = true;
      recomandedProductList.clear();
      notifyListeners();
      recomandedProducts =
          await _service.recomandedProducts(_languageCode.toString());
      recomandedShimmer = false;

      if (recomandedProducts != null) {
        if (recomandedProducts.success == 1) {
          if (recomandedProducts.result != null &&
              recomandedProducts.result.length > 0) {
            recomandedProductList.addAll(recomandedProducts.result);
          } else {
            //_showCategoryEmptyLayout();
          }
        } else {
          //_showCategoryEmptyLayout();
        }
      } else {
        //_showCategoryEmptyLayout();
      }
      notifyListeners();
    } catch (err) {
      notifyListeners();
    }
  }
}
