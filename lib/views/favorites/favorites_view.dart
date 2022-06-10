import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/favorites.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/views/favorites/favorites_view_model.dart';
import 'package:harmis_opencart/views/product_details/product_details_view.dart';
import 'package:provider/provider.dart';

final _globalKey = new GlobalKey<ScaffoldState>();

class FavoritesView extends StatefulWidget {
  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<FavoriteViewModel>(context).wishListStartLimit = 0;
      Provider.of<FavoriteViewModel>(context).getWishList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var _appbar = AppBar(
        backgroundColor: CommonColors.primaryColor,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Text(
            S.of(context).favorites,
            style: TextStyle(
                fontFamily: "Gotik",
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ));
    return Scaffold(
      key: _globalKey,
      appBar: _appbar,
      body: _imageLoaded(context),
    );
  }
}

Widget _imageLoaded(BuildContext context) {
  final mViewModel = Provider.of<FavoriteViewModel>(context);

  return Container(
    color: Colors.white,
    child: NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          if (mViewModel.wishListStartLimit < mViewModel.wishListTotalCount &&
              !mViewModel.brandIsApiLoading) {
            mViewModel.wishListStartLimit += 10;
            mViewModel.getWishList();
          }
        }
      },
      child: ListView.builder(
        itemCount: (mViewModel.brandIsApiLoading)
            ? mViewModel.favoritesDetailsList.length + 1
            : mViewModel.favoritesDetailsList.length,
        itemBuilder: (context, position) {
          return (position == mViewModel.favoritesDetailsList.length)
              ? CommonUtils.getListItemProgressBar()
              : itemCard(mViewModel.favoritesDetailsList[position], position);
        },
        scrollDirection: Axis.vertical,
      ),
    ),
  );
}

class itemCard extends StatefulWidget {
  /// Declaration and Get data from BrandDataList.dart
  final FavoritesDetails favortes;
  final int position;

  itemCard(this.favortes, this.position);

  _itemCardState createState() => _itemCardState(favortes, position);
}

class _itemCardState extends State<itemCard> {
  final FavoritesDetails brand;
  final int position;

  _itemCardState(this.brand, this.position);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => ProductDetailsView(productId: brand.productId,),
              transitionDuration: Duration(milliseconds: 750),
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
        child: Container(
          height: 130.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Slidable(
            delegate: new SlidableDrawerDelegate(),
            actionExtentRatio: 0.25,
            actions: <Widget>[],
            secondaryActions: <Widget>[
              new IconSlideAction(
                key: Key(brand.productId.toString()),
                caption: S.of(context).cartDelete,
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  Provider.of<FavoriteViewModel>(context)
                      .updateWishlist(context, brand.productId, position,
                          success: (String message) {
                    CommonUtils.showSnackBar(message, _globalKey);
                  });
                },
              ),
            ],
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 13.0, left: 13.0, right: 13.0),

              /// Background Constructor for card
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      blurRadius: 3.5,
                      spreadRadius: 0.4,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(10.0),

                            /// Image item
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Colors.black12.withOpacity(0.1),
                                          blurRadius: 0.5,
                                          spreadRadius: 0.1)
                                    ]),
                                child: Image.network(
                                  '${brand.thumbImage}',
                                  height: 80.0,
                                  width: 80.0,
                                  fit: BoxFit.cover,
                                ))),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 15.0),
                            child: Column(
                              /// Text Information Item
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${brand.name}',
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppConstants.FONT_FAMILY,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),

                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    onTap: () {
                                      Provider.of<FavoriteViewModel>(context)
                                          .updateCart(
                                              productId: brand.productId,
                                              quantity: "1",
                                              context: context,
                                              success: (String message) {
                                                CommonUtils.showSnackBar(
                                                    message, _globalKey);
                                              },
                                              fail: (String message) {
                                                CommonUtils.showSnackBar(
                                                    message, _globalKey);
                                              });
                                    },
                                    child: Container(
                                      height: 40.0,
                                      width: 40.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(22.5)),
                                        color: CommonColors.primaryColor,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )

//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      top: 0.0, left: 0.0),
//                                  child: Container(
//                                    width: 100.0,
//                                    child: Row(
//                                      mainAxisAlignment:
//                                      MainAxisAlignment
//                                          .center,
//                                      children: <Widget>[
//
//                                      ],
//                                    ),
//                                  ),
//                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 8.0)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
