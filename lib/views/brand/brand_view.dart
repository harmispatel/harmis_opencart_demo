import 'dart:async';
import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/brand.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/views/brand/brand_view_model.dart';
import 'package:harmis_opencart/views/products/product_view.dart';
import 'package:provider/provider.dart';

bool loadImage = true;

class BrandView extends StatefulWidget {
  @override
  _BrandViewState createState() => _BrandViewState();
}

class _BrandViewState extends State<BrandView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<BrandViewModel>(context).getBrand("0");
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Component appbar
    var _appbar = AppBar(
        backgroundColor: CommonColors.primaryColor,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Text(
            S.of(context).categoryBrand,
            style: TextStyle(
                fontFamily: "Gotik",
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ));
    return Scaffold(
      /// Calling variable appbar
      appBar: _appbar,
      body: _imageLoaded(context),
    );
  }
}

Widget _imageLoaded(BuildContext context) {

  final mViewModel = Provider.of<BrandViewModel>(context);

  return Container(
    color: Colors.white,
    child: NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          if (mViewModel.brandStartLimit < mViewModel.brandTotalCount &&
              !mViewModel.brandIsApiLoading) {
            mViewModel.brandStartLimit += 10;
            Provider.of<BrandViewModel>(context)
                .getBrand(mViewModel.brandStartLimit.toString());
          }
        }
      },
      child: CustomScrollView(
        /// Create List Menu
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(top: 0.0),
            sliver: SliverFixedExtentList(
                itemExtent: 145.0,
                delegate: SliverChildBuilderDelegate(
                    /// Calling itemCard Class for constructor card
                    (context, index) =>
                        (index == mViewModel.brandDetailsList.length)
                            ? CommonUtils.getListItemProgressBar()
                            : itemCard(mViewModel.brandDetailsList[index]),
                    childCount: (mViewModel.brandIsApiLoading)
                        ? mViewModel.brandDetailsList.length + 1
                        : mViewModel.brandDetailsList.length)),
          ),
        ],
      ),
    ),
  );
}

class itemCard extends StatefulWidget {
  /// Declaration and Get data from BrandDataList.dart
  final BrandDetails brand;

  itemCard(this.brand);

  _itemCardState createState() => _itemCardState(brand);
}

class _itemCardState extends State<itemCard> {
  final BrandDetails brand;

  _itemCardState(this.brand);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new ProductView(
                      brand.manufacturerName, brand.manufacturerId, true),
                  transitionDuration: Duration(milliseconds: 600),
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                    return Opacity(
                      opacity: animation.value,
                      child: child,
                    );
                  }),
              (Route<dynamic> route) => true);
        },
        child: Container(
          height: 130.0,
          width: 400.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Material(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                image: new DecorationImage(
                    image: new NetworkImage(brand.image), fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFABABAB).withOpacity(0.3),
                    blurRadius: 1.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: Colors.black12.withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    brand.manufacturerName,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Berlin",
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
