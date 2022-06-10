

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/app.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/life_cycle_event_handler.dart';
import 'package:harmis_opencart/utils/local_images.dart';
import 'package:harmis_opencart/views/cart/cart_view.dart';
import 'package:harmis_opencart/views/search/search_view.dart';
import 'package:provider/provider.dart';

class AppNavBarView extends StatefulWidget {
  @override
  _AppNavBarViewState createState() => _AppNavBarViewState();
}

class _AppNavBarViewState extends State<AppNavBarView> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppModel>(context).getCart();
    });
  }

  @override
  void didUpdateWidget(AppNavBarView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("update widget" + oldWidget.toString());
  }



  @override
  Widget build(BuildContext context) {

    final mViewModel = Provider.of<AppModel>(context);


    /// Create responsive height and padding
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: 58.0 + statusBarHeight,
      decoration: BoxDecoration(
        /// gradient in appbar
          gradient: LinearGradient(
              colors: [
                CommonColors.PrimaryDarkColor,
                CommonColors.primaryColor
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /// if user click shape white in appbar navigate to search layout
          InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => SearchView(),
                  /// transtation duration in animation
                  transitionDuration: Duration(milliseconds: 750),
                  /// animation route to search layout
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                    return Opacity(
                      opacity: animation.value,
                      child: child,
                    );
                  }));
            },
            /// Create shape background white in appbar (background treva shop text)
            child: Container(
              margin: EdgeInsets.only(left: media.padding.left + 15),
              height: 37.0,
              width: 250.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  shape: BoxShape.rectangle),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 17.0)),
                  Image.asset(
                    LocalImages.search2,
                    height: 22.0,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 17.0,
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text(
                      S.of(context).title,
                      style: TextStyle(
                          fontFamily: "Popins",
                          color: Colors.black12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.0,
                          fontSize: 16.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /// Icon chat (if user click navigate to chat layout)

          InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new CartView()));
            },
            child: Stack(
              alignment: AlignmentDirectional(-3.0, -3.0),
              children: <Widget>[
                Image.asset(
                  LocalImages.shopping_cart_white,
                  height: 24.0,
                ),
                CircleAvatar(
                  radius: 8.6,
                  backgroundColor: Colors.redAccent,
                  child: Text(
                    mViewModel.CountNotice,
                    style: TextStyle(fontSize: 13.0, color: Colors.white),
                  ),
                )
              ],
            ),

          ),
        ],
      ),
    );
  }
}
