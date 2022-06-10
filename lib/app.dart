import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/views/account/account_view_model.dart';
import 'package:harmis_opencart/views/add_address/add_address_view_model.dart';
import 'package:harmis_opencart/views/address_list/address_list_view_model.dart';
import 'package:harmis_opencart/views/brand/brand_view_model.dart';
import 'package:harmis_opencart/views/cart/cart_view_model.dart';
import 'package:harmis_opencart/views/change_password/change_password_view_model.dart';
import 'package:harmis_opencart/views/favorites/favorites_view_model.dart';
import 'package:harmis_opencart/views/home/home_view_model.dart';
import 'package:harmis_opencart/views/login/login_view.dart';
import 'package:harmis_opencart/views/login/login_view_model.dart';
import 'package:harmis_opencart/views/my_orders/my_orders_view_model.dart';
import 'package:harmis_opencart/views/notification/notification_view_model.dart';
import 'package:harmis_opencart/views/order_details/order_details_view_model.dart';
import 'package:harmis_opencart/views/order_summary/order_summary_view_model.dart';
import 'package:harmis_opencart/views/product_details/product_details_view_model.dart';
import 'package:harmis_opencart/views/products/product_view_model.dart';
import 'package:harmis_opencart/views/profile/profile_view_model.dart';
import 'package:harmis_opencart/views/register/register_view.dart';
import 'package:harmis_opencart/views/search/search_view_model.dart';
import 'package:harmis_opencart/views/splash/splash_view.dart';
import 'package:harmis_opencart/views/splash/splash_view_model.dart';
import 'package:harmis_opencart/views/sub_categories/sub_category_view_model.dart';
import 'package:harmis_opencart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:harmis_opencart/widgets/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:provider/provider.dart';

import 'generated/i18n.dart';
import 'models/app.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> with AfterLayoutMixin {

  static BuildContext appContext;
  final _app = AppModel();
  AppPreferences appPreferences = new AppPreferences();

//  final _product = ProductModel();
//  final _wishlist = WishListModel();
//  final _shippingMethod = ShippingMethodModel();
//  final _paymentMethod = PaymentMethodModel();
//  final _order = OrderModel();
//  final _search = SearchModel();
//  final _recent = RecentModel();

  @override
  void afterFirstLayout(BuildContext context) {
//    Services().setAppConfig(serverConfig);
//    _app.loadAppConfig();
  }

  @override
  Future initState() {
//    appPreferences.setLanguageCode("en");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appContext = context;
    return ChangeNotifierProvider<AppModel>.value(
      value: _app,
      child: Consumer<AppModel>(
        builder: (context, value, child) {
          value.isLoading = false;

          if (value.isLoading) {
            return Container(
              color: Theme.of(context).backgroundColor,
            );
          }

          return MultiProvider(
            providers: [
//              Provider<ProductModel>.value(value: _product),
//              Provider<WishListModel>.value(value: _wishlist),
//              Provider<ShippingMethodModel>.value(value: _shippingMethod),
//              Provider<PaymentMethodModel>.value(value: _paymentMethod),
//              Provider<OrderModel>.value(value: _order),
//              Provider<SearchModel>.value(value: _search),
//              Provider<RecentModel>.value(value: _recent,),

              ChangeNotifierProvider(builder: (context) => LoginViewModel()),
              ChangeNotifierProvider(builder: (context) => HomeViewModel()),
              ChangeNotifierProvider(builder: (context) => SubCategoryViewModel()),
              ChangeNotifierProvider(builder: (context) => CartViewModel()),
              ChangeNotifierProvider(builder: (context) => BottomNavBarViewModel()),
              ChangeNotifierProvider(builder: (context) => SplashViewModel()),
              ChangeNotifierProvider(builder: (context) => NotificationViewModel()),
              ChangeNotifierProvider(builder: (context) => ChangePasswordViewModel()),
              ChangeNotifierProvider(builder: (context) => BrandViewModel()),
              ChangeNotifierProvider(builder: (context) => ProductViewModel()),
              ChangeNotifierProvider(builder: (context) => ProductDetailsViewModel()),
              ChangeNotifierProvider(builder: (context) => AddAddressViewModel()),
              ChangeNotifierProvider(builder: (context) => SearchViewModel()),
              ChangeNotifierProvider(builder: (context) => AccountViewModel()),
              ChangeNotifierProvider(builder: (context) => ProfileViewModel()),
              ChangeNotifierProvider(builder: (context) => AddressListViewModel()),
              ChangeNotifierProvider(builder: (context) => MyOrdersViewModel()),
              ChangeNotifierProvider(builder: (context) => OrderSummaryViewModel()),
              ChangeNotifierProvider(builder: (context) => OrderDetailsViewModel()),
              ChangeNotifierProvider(builder: (context) => FavoriteViewModel()),

            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: new Locale(Provider.of<AppModel>(context).locale, ""),
//              navigatorObservers: [
//                FirebaseAnalyticsObserver(analytics: analytics),
//              ],
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              localeListResolutionCallback:
              S.delegate.listResolution(fallback: const Locale(AppConstants.LANGUAGE_ENGLISH, '')),
              home: SplashView(),
              routes: <String, WidgetBuilder>{
                "/login": (context) => LoginView(),
                "/register": (context) => RegisteView(),
                "/bottom": (context) => bottomNavigationBar(),

//                "/register": (context) => RegistrationScreen(),
//                '/products': (context) => ProductsPage(),
//                '/wishlist': (context) => WishList(),
//                '/checkout': (context) => Checkout(),
//                '/orders': (context) => MyOrders(),
//                '/onboardscreen': (context) => OnBoardScreen(),
//                '/blogs': (context) => BlogScreen(),
//                '/notify': (context) => Notifications(),
//                '/chatlist': (context) => ListChat(),
//                '/chatscreen': (context) => ChatScreen(),
              },
//              theme: Provider.of<AppModel>(context).darkTheme
//                  ? buildDarkTheme()
//                  .copyWith(primaryColor: HexColor(_app.appConfig["Setting"]["MainColor"]))
//                  : buildLightTheme()
//                  .copyWith(primaryColor: HexColor(_app.appConfig["Setting"]["MainColor"])),
            ),
          );
        },
      ),
    );
  }
}
