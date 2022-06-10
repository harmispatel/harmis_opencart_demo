import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/app.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/utils/custom_text_style.dart';
import 'package:harmis_opencart/utils/local_images.dart';
import 'package:harmis_opencart/views/cart/cart_view.dart';
import 'package:harmis_opencart/views/cart/no_cart_view.dart';
import 'package:harmis_opencart/views/product_details/bottomsheet_description.dart';
import 'package:harmis_opencart/views/product_details/product_details_view_model.dart';
import 'package:harmis_opencart/widgets/carousel_pro/src/carousel_pro.dart';
import 'package:harmis_opencart/widgets/shimmer_view/shimmer_product_details.dart';
import 'package:provider/provider.dart';
import 'package:html/dom.dart' as dom;

class ProductDetailsView extends StatefulWidget {

  String productId = "";

  ProductDetailsView({this.productId});

  @override
  _ProductDetailsViewState createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int valueItemChart = 0;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  void _bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return BottomsheetDescription();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      Provider.of<ProductDetailsViewModel>(context).productDetail = null;
      Provider.of<ProductDetailsViewModel>(context)
          .getProductDetails(widget.productId);
      Provider.of<ProductDetailsViewModel>(context)
          .getCart();
    });
  }

  Widget build(BuildContext context) {
    final mViewModel = Provider.of<ProductDetailsViewModel>(context);

    final mBody = Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Header image slider
              Container(
                height: 300.0,
                child: Material(
                  child: mViewModel.productImageList.length > 0
                      ? new Carousel(
                    dotColor: Colors.black26,
                    dotIncreaseSize: 1.7,
                    dotBgColor: Colors.transparent,
                    autoplay: false,
                    boxFit: BoxFit.cover,
                    images: mViewModel.productImageList,
                  )
                      : Container(
                    height: 300.0,
                    color: CommonColors.silver,
                  ),
                ),
              ),

              /// Background white title,price and ratting
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Color(0xFF656565).withOpacity(0.15),
                    blurRadius: 1.0,
                    spreadRadius: 0.2,
                  )
                ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 10.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        mViewModel.productDetail?.name ?? "",
                        style: CustomTextStyle.customTextStyle,
                      ),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Text(
                        mViewModel.productDetail?.currencyCode.toString() +
                            " " +
                            mViewModel.productDetail?.orginalPrice.toString(),
                        style: CustomTextStyle.customTextStyle,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Divider(
                        color: Colors.black12,
                        height: 1.0,
                      ),
                    ],
                  ),
                ),
              ),

              /// Background white for chose Size and Color
              mViewModel.isOptionsAvailable
                  ? Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: 600.0,
                  decoration:
                  BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Color(0xFF656565).withOpacity(0.15),
                      blurRadius: 1.0,
                      spreadRadius: 0.2,
                    )
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(S.of(context).availableOptions,
                                style: CustomTextStyle
                                    .subHeaderCustomStyle),
                            Padding(
                                padding: EdgeInsets.only(top: 15.0)),
                            Divider(
                              color: Colors.black12,
                              height: 1.0,
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 10.0)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: mViewModel.getOptions(),
                        )
                      ],
                    ),
                  ),
                ),
              )
                  : Container(),

              /// Background white for description
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 45.0),
                child: Container(
                  width: 600.0,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Color(0xFF656565).withOpacity(0.15),
                      blurRadius: 1.0,
                      spreadRadius: 0.2,
                    )
                  ]),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text(
                            S.of(context).description,
                            style: CustomTextStyle.subHeaderCustomStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0,
                              right: 20.0,
                              bottom: 10.0,
                              left: 20.0),
                          child: Html(
                              data:
                              mViewModel.productDetail?.description ?? "",
                              defaultTextStyle: CustomTextStyle.detailText),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //_suggestedItem
            ],
          ),
        ),

        /// If user click icon chart SnackBar show
        /// this code to show a SnackBar
        /// and Increase a valueItemChart + 1
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              height: 45,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        mViewModel.updateWishlist(context, success: (String message){
                          CommonUtils.showSnackBar(message, _globalKey);
                        });
                      },
                      child: Container(
                        color: CommonColors.primaryGreen,
                        child: Center(
                          child: Text(
                            S.of(context).addToFavorite,
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        if (mViewModel.checkValidation()) {
                          mViewModel.updateCart(
                              context: context,
                              success: (String message, String qty) {
                                Provider.of<AppModel>(context).CountNotice = qty;
                                Provider.of<AppModel>(context).notifyListeners();
                                CommonUtils.showSnackBar(message, _globalKey);
                              });
                        } else {
                          CommonUtils.showSnackBar(
                              S.of(context).chooseAvailableOptions, _globalKey);
                        }
                      },
                      child: Container(
                        color: CommonColors.primaryColor,
                        child: Center(
                          child: Text(
                            S.of(context).addToCart,
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );

    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new CartView())).then((value){
                    mViewModel.getCart();
              });
            },
            child: Stack(
              alignment: AlignmentDirectional(-1.0, -0.8),
              children: <Widget>[
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    )),
                CircleAvatar(
                  radius: 10.0,
                  backgroundColor: Colors.red,
                  child: Text(
                    mViewModel.cartQuantity.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
        title: Text(
          S.of(context).productDetails,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 17.0,
            fontFamily: AppConstants.FONT_FAMILY_GOTIK,
          ),
        ),
      ),
      body: mViewModel.isApiLoading
          ? ShimmerProductDetails()
          : mViewModel.isDetailsAvailable
              ? mBody
              : NoDataAvailableView(
                  image: LocalImages.ilustrasiCart,
                  message: S.of(context).cartNoItem),
    );
  }
}

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.black12,
  );
}
