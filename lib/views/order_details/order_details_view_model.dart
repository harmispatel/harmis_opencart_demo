import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/models/order_details.dart';
import 'package:harmis_opencart/models/orders.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/base_services.dart';
import 'package:harmis_opencart/services/service.dart';
import 'package:harmis_opencart/utils/common_utils.dart';

class OrderDetailsViewModel with ChangeNotifier {

  Services _service = Services(new Service());

  int ordersStartLimit = 0, ordersTotalCount = 0;

  bool isShimmer = false;

  bool ordersApiLoading = false, isOrdersListAvailable = true;

  String _languageCode = "";

  LoginDetails loginDetails;

  AppPreferences appPreferences = new AppPreferences();
  AppPreferences appSettings = new AppPreferences();

  OrderHistoryDetails orderHistoryDetails = new OrderHistoryDetails();


  void orderDetails(orderId) async {
    try {
      ordersApiLoading = true;

      notifyListeners();

      if (loginDetails == null)
        loginDetails = await appPreferences.getLoginDetails();

      if (CommonUtils.isEmpty(_languageCode))
        _languageCode = await appSettings.getLanguageCode();

      OrderHistoryMaster orderDetailsMaster = await _service.orderDetails(
          loginDetails.userId.toString(), orderId, _languageCode);

      orderHistoryDetails = orderDetailsMaster.result;

      ordersApiLoading = false;
      isShimmer = false;

//      if (master != null) {
//        if (master.success == 1) {
//          ordersTotalCount = master.total;
//          if (master.result != null && master.result.length > 0) {
//            if (ordersStartLimit == 0) ordersDetailsList.clear();
//            ordersDetailsList.addAll(master.result);
//          } else {
//            _showCategoryEmptyLayout();
//          }
//        } else {
//          _showCategoryEmptyLayout();
//        }
//      } else {
//        _showCategoryEmptyLayout();
//      }
      notifyListeners();
    } catch (err) {
      ordersApiLoading = false;
      notifyListeners();
    }
  }

  void _showCategoryEmptyLayout() {
    if (ordersStartLimit == 0) {
      isOrdersListAvailable = false;
    }
  }
}
