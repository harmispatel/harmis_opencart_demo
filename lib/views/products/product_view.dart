import 'package:flutter/material.dart';
import 'package:harmis_opencart/models/app.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/views/product_details/product_details_view.dart';
import 'package:harmis_opencart/views/products/product_item.dart';
import 'package:harmis_opencart/views/products/product_view_model.dart';
import 'package:harmis_opencart/widgets/shimmer_view/ShimmerGridList.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  String title = "";
  String catId = "";
  bool isFromManufec = false;

  ProductView(this.title, this.catId, this.isFromManufec);

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    if (widget.isFromManufec) {
      Future.delayed(Duration.zero, () {
        Provider.of<ProductViewModel>(context).startLimit = 0;
        Provider.of<ProductViewModel>(context).getManufecturerProductListApi(widget.catId);
      });
    } else {
      Future.delayed(Duration.zero, () {
        Provider.of<ProductViewModel>(context).startLimit = 0;
        Provider.of<ProductViewModel>(context).getProductListApi(widget.catId);
      });
    }


  }

  @override
  Widget build(BuildContext context) {

    final mViewModel = Provider.of<ProductViewModel>(context);

    /// Grid Item a product
    var _grid = mViewModel.imageLoad
        ? ShimmerGridList()
        : NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                if (mViewModel.startLimit < mViewModel.totalCount &&
                    !mViewModel.isApiLoading) {
                  mViewModel.startLimit += 10;
                  Provider.of<ProductViewModel>(context)
                      .getProductListApi(widget.catId);
                }
              }
            },
            child: GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 0.545,
              crossAxisCount: 2,
              primary: false,
              children: List.generate(
                /// Get data in flashSaleItem.dart (ListItem folder)
                (mViewModel.isApiLoading)
                    ? mViewModel.productList.length + 1
                    : mViewModel.productList.length,
                (index) => (index == mViewModel.productList.length)
                    ? CommonUtils.getListItemProgressBar()
                    : ProductItem(
                        item: mViewModel.productList[index],
                        productTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => ProductDetailsView(productId: mViewModel.productList[index].productId,),
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
                        addToCartTap: () {
                          mViewModel.updateCart(
                              context: context,
                              productId:
                                  mViewModel.productList[index].productId,
                              quantity: mViewModel.productList[index].quantity,
                              success: (String message, String qty) {
                                Provider.of<AppModel>(context).CountNotice = qty;
                                Provider.of<AppModel>(context).notifyListeners();
                                CommonUtils.showSnackBar(message, globalKey);
                              },
                              fail: (String message) {
                                CommonUtils.showSnackBar(message, globalKey);
                              });
                        },
                      ),
              ),
            ));
    return Scaffold(
      /// Appbar item
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title ?? "",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Colors.white,
              fontFamily: AppConstants.FONT_FAMILY_GOTIK),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: CommonColors.primaryColor,
        elevation: 0.0,
      ),
      key: globalKey,
      body: _grid,
    );
  }
}
