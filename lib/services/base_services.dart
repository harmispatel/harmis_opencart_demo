import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:harmis_opencart/models/brand.dart';
import 'package:harmis_opencart/models/address.dart';
import 'package:harmis_opencart/models/banner.dart';
import 'package:harmis_opencart/models/best_seller.dart';
import 'package:harmis_opencart/models/cart.dart';
import 'package:harmis_opencart/models/categories.dart';
import 'package:harmis_opencart/models/country_master.dart';
import 'package:harmis_opencart/models/coupon.dart';
import 'package:harmis_opencart/models/delete_address.dart';
import 'package:harmis_opencart/models/favorites.dart';
import 'package:harmis_opencart/models/message_master.dart';
import 'package:harmis_opencart/models/notification.dart';
import 'package:harmis_opencart/models/order_details.dart';
import 'package:harmis_opencart/models/orders.dart';
import 'package:harmis_opencart/models/product.dart';
import 'package:harmis_opencart/models/product_details.dart';
import 'package:harmis_opencart/models/state_master.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/services/service.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:http/http.dart' as http;

import 'api_para.dart';
import 'api_url.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

abstract class BaseServices {

}

class Services implements BaseServices {
  Service serviceApi;

  Services(this.serviceApi);

  @override
  Future<LoginMaster> userDetails(String params) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final http.Response response =
        await http.post(ApiUrl.USER_DETAILS, body: params);
        print("URL: " + response.request.url.toString());
        if (response.statusCode == 200) {
          print(response.body);
          return LoginMaster.fromJson(json.decode(response.body));
        } else {
          throw Exception("The username or password is incorrect.");
        }
      } catch (err) {
        throw err;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<LoginMaster> login({username, password, deviceToken, languageCode}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getLoginParams() {
        var map = new Map<String, dynamic>();

        map[ApiParams.deviceToken] = deviceToken;
        map[ApiParams.sessionId] = "";
        map[ApiParams.email] = username;
        map[ApiParams.password] = password;
        map[ApiParams.languageCode] = languageCode;
        if (Platform.isAndroid)
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
        else
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;

        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final http.Response response =
        await http.post(ApiUrl.LOGIN, body: getLoginParams());
        print("URL: " + response.request.url.toString());
        return LoginMaster.fromJson(json.decode(response.body));
      } catch (err) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<LoginMaster> createUser({
    firstName,
    lastName,
    email,
    password,
    phone,
    deviceToken,
    languageCode
  }) async {
    // TODO: implement createUser
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getRegisterParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.deviceToken] = deviceToken;
        map[ApiParams.name] = firstName + lastName;
        map[ApiParams.phone] = phone;
        map[ApiParams.firstName] = firstName;
        map[ApiParams.lastName] = lastName;
        map[ApiParams.sessionId] = "";
        map[ApiParams.email] = email;
        map[ApiParams.password] = password;
        map[ApiParams.languageCode] = languageCode;
        if (Platform.isAndroid)
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
        else
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;

        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final http.Response response =
        await http.post(ApiUrl.REGISTER, body: getRegisterParams());

        return LoginMaster.fromJson(json.decode(response.body));
      } catch (err) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<List<BannerDetails>> getBanners(languageCode) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getBannerParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        return json.encode(map);
      }

      try {
        final response =
        await http.post(ApiUrl.GET_BANNER, body: getBannerParams());
        print("URL: " + response.request.url.toString());
        Banners bannerMaster = Banners.fromJson(json.decode(response.body));
        return bannerMaster.result;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<CategoryMaster> getCategories(String languageCode, int offset) async {
    // TODO: implement getCategories
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getCategoriesParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.offset] = offset.toString();
        if (Platform.isAndroid)
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
        else
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final response =
        await http.post(ApiUrl.GET_CATEGORIES, body: getCategoriesParams());
        CategoryMaster categoryMaster =
        CategoryMaster.fromJson(json.decode(response.body));
        return categoryMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<List<BestSellerDetails>> getBestSellers(languageCode) async {
    // TODO: implement getBestSellers
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getCategoriesParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final response =
        await http.post(ApiUrl.GET_BEST_SELLERS, body: getCategoriesParams());
        print("URL: " + response.request.url.toString());
        BestSellerMaster bannerMaster =
        BestSellerMaster.fromJson(json.decode(response.body));
        return bannerMaster.result;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<CategoryMaster> getSubCategories(
      {languageCode, categoryId, offset}) async {
    // TODO: implement getSubCategories
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getSubCategoriesParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.catId] = categoryId;
        map[ApiParams.offset] = offset;
        if (Platform.isAndroid)
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
        else
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final response = await http.post(ApiUrl.GET_SUB_CATEGORIES,
            body: getSubCategoriesParams());
        print("URL: " + response.request.url.toString());
        CategoryMaster categoryMaster =
        CategoryMaster.fromJson(json.decode(response.body));
        print(response.body);
        return categoryMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<CartMaster> getCart(String userId, String languageCode) async {
    // TODO: implement getCart
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getCartParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.sessionId] = "";
        map[ApiParams.userId] = userId;
        if (Platform.isAndroid)
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
        else
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final response = await http.post(ApiUrl.GET_CART, body: getCartParams());
        print("URL: " + response.request.url.toString());
        CartMaster cartMaster = CartMaster.fromJson(json.decode(response.body));
        print(response.body);
        return cartMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<AddressMaster> getAddress(String userId, String languageCode) async {
    // TODO: implement getAddress
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getAddressParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.userId] = userId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final response =
        await http.post(ApiUrl.GET_ADDRESS, body: getAddressParams());
        AddressMaster addressMaster =
        AddressMaster.fromJson(json.decode(response.body));
        print(response.body);
        return addressMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<CartMaster> deleteCarItem(
      productId, referenceId, String userId, String languageCode) async {
    // TODO: implement deleteCarItem
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getCartParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.sessionId] = "";
        map[ApiParams.userId] = userId;
        if (Platform.isAndroid)
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
        else
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
        map[ApiParams.productId] = productId;
        map[ApiParams.referenceId] = referenceId;
        print("Parameter delete: " + json.encode(map));
        return json.encode(map);
      }

      print(ApiUrl.DELETE_PRODUCT_CART);

      try {
        final response =
        await http.post(ApiUrl.DELETE_PRODUCT_CART, body: getCartParams());
        CartMaster cartMaster = CartMaster.fromJson(json.decode(response.body));
        return cartMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<NotificationMaster> getNotifications({offset, languageCode, userId}) async {
    // TODO: implement getNotifications
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getNotificationParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.offset] = offset;
        map[ApiParams.userId] = userId;
        if (Platform.isAndroid)
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
        else
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final response = await http.post(ApiUrl.GET_NOTIFICAIONS,
            body: getNotificationParams());
        NotificationMaster categoryMaster =
        NotificationMaster.fromJson(json.decode(response.body));
        print(response.body);
        return categoryMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<LoginMaster> changePassword({userId, password, phone, languageCode}) async {
    // TODO: implement changePassword
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getChanagePasswordParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.password] = password;
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.phone] = phone;
        map[ApiParams.userId] = userId;

        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final http.Response response = await http.post(ApiUrl.CHANGE_PASSWORD,
            body: getChanagePasswordParams());
        print("URL: " + response.request.url.toString());
        if (response.statusCode == 200) {
          print(response.body);
          return LoginMaster.fromJson(json.decode(response.body));
        } else {
          throw Exception("The username or password is incorrect.");
        }
      } catch (err) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<BrandMaster> getBrads(offset) async {
    // TODO: implement getBrads
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getBrandParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.offset] = offset;
        return json.encode(map);
      }

      try {
        final response =
        await http.post(ApiUrl.GET_BRAND, body: getBrandParams());
        print(response.body);
        BrandMaster brandMaster =
        BrandMaster.fromJson(json.decode(response.body));
        return brandMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  Future<ProductMaster> getProductList(String params) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final response = await http.post(ApiUrl.GET_PRODUCTS, body: params);
        print(response.request.url);
        ProductMaster productMaster =
        ProductMaster.fromJson(json.decode(response.body));
        return productMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  Future<ProductMaster> getManufecturerProductList(String params) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final response = await http
            .post(ApiUrl.GET_MANUFACTURER_PRODUCT_DETAILS, body: params);
        print(response.request.url);
        ProductMaster productMaster =
        ProductMaster.fromJson(json.decode(response.body));
        return productMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  Future<ProductDetailMaster> getProductDetails(String params) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final response =
        await http.post(ApiUrl.GET_PRODUCT_DETAILS, body: params);
        print(response.request.url);
        ProductDetailMaster productMaster =
        ProductDetailMaster.fromJson(json.decode(response.body));
        return productMaster;
      } catch (e) {
        print(e.toString());
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<CountryMasterM> getCountries() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final response = await http.get(ApiUrl.GET_COUNTRIES);
        CountryMasterM countryMasterM =
        CountryMasterM.fromJson(json.decode(response.body));
        return countryMasterM;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<ProductMaster> searchProduct(String seachText, int offset, String languageCode) async {
    // TODO: implement searchProduct
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String getSearchParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.offset] = offset.toString();
        map[ApiParams.keyword] = seachText;
        map[ApiParams.languageCode] = languageCode;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      print(ApiUrl.SEARCH);

      try {
        final response = await http.post(ApiUrl.SEARCH, body: getSearchParams());
        print(response.body);
        ProductMaster brandMaster =
        ProductMaster.fromJson(json.decode(response.body));
        return brandMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  void updateProfile({
    String fname,
    String lname,
    String email,
    String phone,
    String imagePath,
    String languageCode,
    String userId,
    String deviceToken,
    Function success,
  }) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final request = await http.MultipartRequest(
          AppConstants.METHOD_POST, Uri.parse(ApiUrl.UPDATE_PROFILE));

      if (Platform.isAndroid)
        request.fields[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
      else
        request.fields[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
      request.fields[ApiParams.deviceToken] = deviceToken;
      request.fields[ApiParams.userId] = userId;
      request.fields[ApiParams.firstName] = fname;
      request.fields[ApiParams.lastName] = lname;
      request.fields[ApiParams.email] = email;
      request.fields[ApiParams.phone] = phone;
      request.fields[ApiParams.sessionId] = "";
      request.fields[ApiParams.languageCode] = languageCode;

      try {
        if (imagePath != null || !imagePath.startsWith("http")) {
          File imageFile = new File(imagePath);
          var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
          var length = await imageFile.length();
          var multipartFile = new http.MultipartFile(
              ApiParams.profileImage, stream, length,
              filename: basename(imageFile.path));
          request.files.add(multipartFile);
        }
      } catch (e) {}

      request.send().then((response) {
        print("URL: " + response.request.url.toString());
        try {
          response.stream.transform(utf8.decoder).listen((value) {
            print("Response: " + value);
            print("statusCode: " + response.statusCode.toString());
            if (response.statusCode == 200) {
              LoginMaster user = LoginMaster.fromJson(json.decode(value));
              success(user);
            }
          });
        } catch (e) {
          print("Error: " + e.toString());
        }
      });
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<DeleteAddressMaster> deleteAddress(
      String userId, String addressId, String languageCode) async {
    // TODO: implement deleteAddress
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String deleteAddressParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.userId] = userId;
        map[ApiParams.addressId] = addressId;
        map[ApiParams.languageCode] = languageCode;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final response =
        await http.post(ApiUrl.DELETE_ADDRESS, body: deleteAddressParams());
        print(response.body);
        DeleteAddressMaster brandMaster =
        DeleteAddressMaster.fromJson(json.decode(response.body));
        return brandMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<OrderDetailsMaster> myOrders(
      String userId, String offset, String languageCode) async {
    // TODO: implement myOrders
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String deleteAddressParams() {
        var map = new Map<String, dynamic>();

        if (Platform.isAndroid)
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
        else
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.offset] = offset;
        map[ApiParams.userId] = userId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final response =
        await http.post(ApiUrl.MY_ORDERS, body: deleteAddressParams());
        print(response.body);
        OrderDetailsMaster brandMaster =
        OrderDetailsMaster.fromJson(json.decode(response.body));
        return brandMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<ProductMaster> recomandedProducts(String languageCode) async {
    // TODO: implement recomandedProducts
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String deleteAddressParams() {
        var map = new Map<String, dynamic>();
        map[ApiParams.languageCode] = languageCode;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final response = await http.post(ApiUrl.RECOMANDED_PRODUCTS,
            body: deleteAddressParams());
        print(response.body);
        ProductMaster brandMaster =
        ProductMaster.fromJson(json.decode(response.body));
        return brandMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  Future<StateMaster> getStates(String params) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final response = await http.post(ApiUrl.GET_STATES, body: params);
        print(response.request.url);
        StateMaster master = StateMaster.fromJson(json.decode(response.body));
        return master;
      } catch (e) {
        print(e.toString());
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  Future<MessageMaster> addAddress(String params) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final response = await http.post(ApiUrl.ADD_ADDRESS, body: params);
        print(response.request.url);
        MessageMaster master =
        MessageMaster.fromJson(json.decode(response.body));
        return master;
      } catch (e) {
        print(e.toString());
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<OrderHistoryMaster> orderDetails(
      String userId, String orderId, String languageCode) async {
    // TODO: implement orderDetails
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String oredeDetailsAddressParams() {

        var map = new Map<String, dynamic>();

        if (Platform.isAndroid)
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
        else
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.orderId] = orderId;
        map[ApiParams.userId] = userId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final response =
        await http.post(ApiUrl.GET_ORDER_DETAILS, body: oredeDetailsAddressParams());
        print(response.body);
        OrderHistoryMaster brandMaster =
        OrderHistoryMaster.fromJson(json.decode(response.body));
        return brandMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  Future<CouponMaster> applyCouponCode(String params) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final response =
        await http.post(ApiUrl.APPLY_COUPON_CODE, body: params);
        print(response.request.url);
        CouponMaster master = CouponMaster.fromJson(json.decode(response.body));
        return master;
      } catch (e) {
        print(e.toString());
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  Future<MessageMaster> placeOrder(String params) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final response = await http.post(ApiUrl.PLACE_ORDER, body: params);
        print(response.request.url);
        MessageMaster master =
        MessageMaster.fromJson(json.decode(response.body));
        return master;
      } catch (e) {
        print(e.toString());
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<FavoritesMaster> getWishList(languageCode, offset, userId) async {
    // TODO: implement getWishList
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String WishListParams() {

        var map = new Map<String, dynamic>();

        if (Platform.isAndroid)
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
        else
          map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
        map[ApiParams.languageCode] = languageCode;
        map[ApiParams.offset] = offset;
        map[ApiParams.userId] = userId;
        print("Parameter: " + json.encode(map));
        return json.encode(map);
      }

      try {
        final response =
        await http.post(ApiUrl.GET_WISH_LIST, body: WishListParams());
        print(response.body);
        FavoritesMaster brandMaster =
        FavoritesMaster.fromJson(json.decode(response.body));
        return brandMaster;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<CartMaster> updateCart(
      productId, quantity, action, String userId, options, languageCode,
      {Function onStartLoading,
        Function onStopLoading,
        Function onNoInternet}) async {
    String getCartParams() {
      var map = new Map<String, dynamic>();
      map[ApiParams.languageCode] = languageCode;
      map[ApiParams.sessionId] = "";
      map[ApiParams.userId] = userId;
      if (Platform.isAndroid)
        map[ApiParams.device] = AppConstants.DEVICE_ACCESS_ANDROID;
      else
        map[ApiParams.device] = AppConstants.DEVICE_ACCESS_IOS;
      map[ApiParams.productId] = productId;
      map[ApiParams.quantity] = quantity;
      map[ApiParams.action] = action;
      if (options != null) map[ApiParams.options] = options;

      print("Parameter: " + json.encode(map));
      return json.encode(map);
    }

    // TODO: implement updateCart
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        if (onStartLoading != null) onStartLoading();
        final response =
        await http.post(ApiUrl.UPDATE_CART, body: getCartParams());
        print("URL: " + response.request.url.toString());
        CartMaster cartMaster = CartMaster.fromJson(json.decode(response.body));
        if (onStopLoading != null) onStopLoading();
        return cartMaster;
      } catch (e) {
        if (onStopLoading != null) onStopLoading();
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  Future<MessageMaster> updateWishlist(String params,
      {Function onStartLoading,
        Function onStopLoading,
        Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        if (onStartLoading != null) onStartLoading();
        final response = await http.post(ApiUrl.UPDATE_WISHLIST, body: params);
        print(response.request.url);
        MessageMaster master =
        MessageMaster.fromJson(json.decode(response.body));
        if (onStopLoading != null) onStopLoading();
        return master;
      } catch (e) {
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }

  Future<LoginMaster> socialLogin(String params,
      {Function onStartLoading,
        Function onStopLoading,
        Function onNoInternet}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        if (onStartLoading != null) onStartLoading();
        final response = await http.post(ApiUrl.SOCIAL_LOGIN, body: params);
        print(response.request.url);
        LoginMaster master = LoginMaster.fromJson(json.decode(response.body));
        if (onStopLoading != null) onStopLoading();
        return master;
      } catch (e) {
        if (onStopLoading != null) onStopLoading();
        return null;
      }
    } else {
      if (onNoInternet != null) onNoInternet();
    }
  }
}
