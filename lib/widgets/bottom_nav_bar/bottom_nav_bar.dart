import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/app.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/views/account/account_view.dart';
import 'package:harmis_opencart/views/brand/brand_view.dart';
import 'package:harmis_opencart/views/cart/cart_view.dart';
import 'package:harmis_opencart/views/favorites/favorites_view.dart';
import 'package:harmis_opencart/views/home/home_view.dart';
import 'package:harmis_opencart/views/order_summary/order_summary_view.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_bar_view_model.dart';

class bottomNavigationBar extends StatefulWidget {
  @override
  _bottomNavigationBarState createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {



  @override
  void initState() {
    super.initState();
  }

  /// Set a type current number a layout class
  Widget callPage(int current) {

    switch (current) {
      case 0:
        return HomeView();
      case 1:
        return new FavoritesView(); //new brand();
      case 2:
        return new CartView(); //new cart();
      case 3:
        return new AccountView();//new profil();
        break;
      default:
        return new Text("Home");//Menu(); //Menu();
    }
  }



  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    final mViewModel = Provider.of<BottomNavBarViewModel>(context);
    return Scaffold(
      body: callPage(mViewModel.currentIndex),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: TextStyle(color: Colors.black26.withOpacity(0.15)))),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: mViewModel.currentIndex,
            fixedColor: CommonColors.primaryColor,
            onTap: (value) {
              mViewModel.selectedTab(value, context);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 23.0,
                  ),
                  title: Text(
                    S.of(context).home,
                    style: TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  title: Text(
                    S.of(context).favorites,
                    style: TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text(
                    S.of(context).cart,
                    style: TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 24.0,
                  ),
                  title: Text(
                    S.of(context).account,
                    style: TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
                  )),
            ],
          )),
    );
  }
}
