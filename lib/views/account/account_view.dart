import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/utils/local_images.dart';
import 'package:harmis_opencart/views/about_app/about_app_view.dart';
import 'package:harmis_opencart/views/account/account_category_view.dart';
import 'package:harmis_opencart/views/account/account_view_model.dart';
import 'package:harmis_opencart/views/account/profile_header_view.dart';
import 'package:harmis_opencart/views/call_center/call_center_view.dart';
import 'package:harmis_opencart/views/cart/cart_view_model.dart';
import 'package:harmis_opencart/views/language/language_settings_view.dart';
import 'package:harmis_opencart/views/my_orders/my_orders_view.dart';
import 'package:harmis_opencart/views/notification/notification_view.dart';
import 'package:harmis_opencart/views/setting_acount/setting_acount_view.dart';
import 'package:harmis_opencart/widgets/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:provider/provider.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  AppPreferences appPreferences = new AppPreferences();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AccountViewModel>(context).getUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: (Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: 240.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(LocalImages.headerProfile),
                      fit: BoxFit.cover)),
            ),
            ProfileHeaderView(),
            Padding(
              padding: const EdgeInsets.only(top: 360.0),
              child: Column(
                /// Setting Category List
                children: <Widget>[
                  /// Call category class
                  AccountCategoryView(
                    txt: S.of(context).notification,
                    padding: 35.0,
                    image: LocalImages.p_notification,
                    tap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new NotificationView()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 85.0, right: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  AccountCategoryView(
                    txt: S.of(context).myOrders,
                    padding: 23.0,
                    image: LocalImages.truck,
                    tap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new MyOrdersView()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 85.0, right: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  AccountCategoryView(
                    txt: S.of(context).settingAccount,
                    padding: 30.0,
                    image: LocalImages.setting,
                    tap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                          new SettingAcountView()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 85.0, right: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  AccountCategoryView(
                    txt: S.of(context).callCenter,
                    padding: 30.0,
                    image: LocalImages.callCenter,
                    tap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new CallCenterView()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 85.0, right: 30.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 2.0,
                    ),
                  ),
                  AccountCategoryView(
                    padding: 38.0,
                    txt: S.of(context).aboutApps,
                    image: LocalImages.aboutApp,
                    tap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new AboutAppsView()));
                    },
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20.0)),
                  InkWell(
                    onTap: () {
                      _showDialog();
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 30.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 30.0),
                                child: Icon(
                                  Icons.exit_to_app,
                                  size: 25.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Text(
                                  S.of(context).logout,
                                  style: TextStyle(
                                      fontFamily: AppConstants.FONT_FAMILY,
                                      fontSize: 14.5,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20.0)),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(S.of(context).logout),
          content:
          new Text(S.of(context).logoutConfirmationMessage),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(S.of(context).no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            new FlatButton(
              child: new Text(S.of(context).yes),
              onPressed: () {
                appPreferences.setLoginDetails(null);
                appPreferences.setLoggedIn(isLoggedIn: false);
                Navigator.of(context).pop();
                Provider.of<BottomNavBarViewModel>(context).selectedTab(0, context);
              },
            ),
          ],
        );
      },
    );
  }
}
