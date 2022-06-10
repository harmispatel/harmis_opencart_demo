import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/app.dart';
import 'package:harmis_opencart/models/product_test.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/views/home/best_seller_item.dart';
import 'package:harmis_opencart/views/home/category_item.dart';
import 'package:harmis_opencart/views/home/home_view_model.dart';
import 'package:harmis_opencart/views/home/recommed_item.dart';
import 'package:harmis_opencart/views/products/product_view.dart';
import 'package:harmis_opencart/views/sub_categories/sub_category_view.dart';
import 'package:harmis_opencart/widgets/app_nav_bar/app_nav_bar.dart';
import 'package:harmis_opencart/widgets/carousel_pro/carousel_pro.dart';
import 'package:harmis_opencart/widgets/shimmer_view/ShimmerCategoryList.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void didUpdateWidget(HomeView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("update widget");
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      Provider.of<HomeViewModel>(context).getBanners();
      Provider.of<HomeViewModel>(context).getBestSellers();
      Provider.of<HomeViewModel>(context).getCategories();
      Provider.of<HomeViewModel>(context).recomandedProductAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double size = mediaQueryData.size.height;

    final mViewModel = Provider.of<HomeViewModel>(context);

    /// ImageSlider in header
    var imageSlider = Container(
      height: 182.0,
      child: mViewModel.bannerImageList.length > 0
          ? new Carousel(
              boxFit: BoxFit.fill,
              dotColor: Color(0xFF6991C7).withOpacity(0.8),
              dotSize: 5.5,
              dotSpacing: 16.0,
              dotBgColor: Colors.transparent,
              showIndicator: true,
              overlayShadow: true,
              overlayShadowColors: Colors.white.withOpacity(0.9),
              overlayShadowSize: 0.9,
              images: mViewModel.bannerImageList,
            )
          : Container(
              height: 182.0,
              color: Colors.grey,
            ),
    );

    var PromoHorizontalList = Container(
      color: Colors.white,
      height: 320.0,
      padding: EdgeInsets.only(bottom: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  left: 20.0, top: 15.0, bottom: 3.0, right: 20.0),
              child: Text(
                S.of(context).weekPromotion,
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: AppConstants.FONT_FAMILY,
                    fontWeight: FontWeight.w700),
              )),
          Expanded(
            child: mViewModel.bestSellerShimmer
                ? ShimmerCategoryList()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: mViewModel.bestSellers.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return ItemBestSeller(mViewModel.bestSellers[index]);
                    }),
          ),
        ],
      ),
    );

    var categoryImageBottom = Container(
      height: 200.0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            child: Text(
              S.of(context).category,
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstants.FONT_FAMILY),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 4.0, right: 4.0, top: 10.0, bottom: 10.0),
              child: mViewModel.categoryShimmer
                  ? ShimmerCategoryList()
                  : NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          if (mViewModel.categoryStartLimit <
                                  mViewModel.categoryTotalCount &&
                              !mViewModel.categoryIsApiLoading) {
                            print("NOtification listener");
                            mViewModel.categoryStartLimit += 10;
                            Provider.of<HomeViewModel>(context).getCategories();
                          }
                        }
                      },
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: (mViewModel.categoryIsApiLoading)
                              ? mViewModel.categoryList.length + 1
                              : mViewModel.categoryList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return (index == mViewModel.categoryList.length)
                                ? CommonUtils.getListItemProgressBar()
                                : CategoryItemValue(
                                    category: mViewModel.categoryList[index],
                                    tap: () {
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  mViewModel.categoryList[index]
                                                              .hasSubCategory ==
                                                          1
                                                      ? new SubCategoryView(
                                                          catId: mViewModel
                                                              .categoryList[
                                                                  index]
                                                              .catId,
                                                          catName: mViewModel
                                                              .categoryList[
                                                                  index]
                                                              .name,
                                                        )
                                                      : new ProductView(
                                                          mViewModel
                                                              .categoryList[
                                                                  index]
                                                              .name,
                                                          mViewModel
                                                              .categoryList[
                                                                  index]
                                                              .catId,
                                                          false),
                                              transitionDuration:
                                                  Duration(milliseconds: 750),
                                              transitionsBuilder: (_,
                                                  Animation<double> animation,
                                                  __,
                                                  Widget child) {
                                                return Opacity(
                                                  opacity: animation.value,
                                                  child: child,
                                                );
                                              }));
                                    },
                                  );
                          }),
                    ),
            ),
          )
        ],
      ),
    );

    ///  Grid item in bottom of Category
    var Grid = Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0),
            child: Text(
              S.of(context).category,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
              ),
            ),
          ),
          GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
              shrinkWrap: true,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 17.0,
              childAspectRatio: 0.8,
              crossAxisCount: 2,
              primary: false,
              children: List.generate(
                (mViewModel.categoryIsApiLoading)
                    ? mViewModel.categoryList.length + 1
                    : mViewModel.categoryList.length,
                (index) => (index == mViewModel.categoryList.length)
                    ? CommonUtils.getListItemProgressBar()
                    : RecommedItemGrid(mViewModel.categoryList[index]),
              ))
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                if (mViewModel.categoryStartLimit <
                        mViewModel.categoryTotalCount &&
                    !mViewModel.categoryIsApiLoading) {
                  mViewModel.categoryStartLimit += 10;
                  Provider.of<HomeViewModel>(context).getCategories();
                }
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: mediaQueryData.padding.top + 58.5)),

                  /// Call var imageSlider
                  imageSlider,
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
                  ),
                  // Call var PromoHorizontalList
                  PromoHorizontalList,
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
                  ),
//                categoryImageBottom,
//                Padding(
//                  padding: EdgeInsets.only(bottom: 0.0),
//                ),
                  Grid,
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                  ),
                ],
              ),
            ),
          ),
          AppNavBarView()
        ],
      ),
    );
  }
}
