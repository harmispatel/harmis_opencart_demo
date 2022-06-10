import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/address.dart';
import 'package:harmis_opencart/models/cart.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/utils/local_images.dart';
import 'package:harmis_opencart/views/cart/no_cart_view.dart';
import 'package:harmis_opencart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:harmis_opencart/widgets/shimmer_view/shimmer_product_details.dart';
import 'package:provider/provider.dart';

import 'order_summary_view_model.dart';

class OrderSummaryView extends StatefulWidget {
  CartMaster cartMaster;
  AddressDetails addressDetails;

  OrderSummaryView(this.cartMaster, this.addressDetails);

  @override
  _OrderSummaryViewState createState() => _OrderSummaryViewState();
}

class _OrderSummaryViewState extends State<OrderSummaryView> {
  var _couponCodeController = new TextEditingController();
  var _commentController = new TextEditingController();
  final _globalKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<OrderSummaryViewModel>(context)
          .setDetails(widget.cartMaster, widget.addressDetails);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mViewModel = Provider.of<OrderSummaryViewModel>(context);

    var _appbar = AppBar(
        backgroundColor: CommonColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Text(
            S.of(context).orderSummary,
            style: TextStyle(
                fontFamily: AppConstants.FONT_FAMILY_GOTIK,
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ));

    final totalQuantityRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).totalQuantity,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: AppConstants.FONT_FAMILY,
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            mViewModel.cartMaster?.quantity ?? "",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: AppConstants.FONT_FAMILY,
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );

    final itemAmountRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).itemAmount,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: AppConstants.FONT_FAMILY,
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            mViewModel.cartMaster.currencyCode.toString() +
                    " " +
                    mViewModel.cartMaster.subTotal,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: AppConstants.FONT_FAMILY,
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );

    final shippingAmountRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).shippingAmount,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: AppConstants.FONT_FAMILY,
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            mViewModel.cartMaster.currencyCode +
                    " " +
                    mViewModel.cartMaster?.shippingCharge ??
                "",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: AppConstants.FONT_FAMILY,
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );

    final couponDiscountRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).couponDiscount,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: AppConstants.FONT_FAMILY,
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            mViewModel.cartMaster.currencyCode.toString() +
                " " +
                mViewModel.cartMaster.discountValue.toString(),
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: AppConstants.FONT_FAMILY,
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );

    final paymentRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).payment,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: AppConstants.FONT_FAMILY,
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).cashOnDelivery,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: AppConstants.FONT_FAMILY,
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );

    final footerView = Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  color: CommonColors.primaryGreen,
                  child: Center(
                    child: Text(
                      mViewModel.cartMaster.currencyCode +
                          " " +
                          mViewModel.cartMaster.total,
                      style: TextStyle(
                          fontFamily: AppConstants.FONT_FAMILY,
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    // On Place order click
                    mViewModel.placeOrder(_commentController.text, onMessage: (String message){
                      CommonUtils.showSnackBar(message, _globalKey);
                    }, onSuccess: (String message){
                      _showDialog(message);
                      StartTime();
                    });
                  },
                  child: Container(
                    color: CommonColors.primaryColor,
                    child: Center(
                      child: Text(
                        S.of(context).placeOrder,
                        style: TextStyle(
                            fontFamily: AppConstants.FONT_FAMILY,
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));

    final mBody = Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 60, left: 8.0, right: 8.0, top: 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent,
                        blurRadius: 3.5,
                        spreadRadius: 0.4,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      totalQuantityRow,
                      Padding(
                        padding: EdgeInsets.only(top: 6.0),
                      ),
                      itemAmountRow,
                      Padding(
                        padding: EdgeInsets.only(top: 6.0),
                      ),
                      shippingAmountRow,
                      mViewModel.cartMaster.discountValue != null
                          ? Padding(
                              padding: EdgeInsets.only(top: 6.0),
                              child: couponDiscountRow,
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.only(top: 6.0),
                      ),
                      paymentRow
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),

                // Shippin address
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent,
                        blurRadius: 3.5,
                        spreadRadius: 0.4,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        S.of(context).shippingAddress + ":",
                        style: TextStyle(
                            fontFamily: AppConstants.FONT_FAMILY,
                            fontSize: 15.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6.0),
                      ),
                      Text(
                        mViewModel.addressDetails?.fullAddress ?? "",
                        style: TextStyle(
                            fontFamily: AppConstants.FONT_FAMILY,
                            fontSize: 14.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),

                // Payment Address
                /*Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent,
                        blurRadius: 3.5,
                        spreadRadius: 0.4,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        S.of(context).paymentAddress + ":",
                        style: TextStyle(
                            fontFamily: AppConstants.FONT_FAMILY,
                            fontSize: 15.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6.0),
                      ),
                      Text(
                        "Payment address test test test",
                        style: TextStyle(
                            fontFamily: AppConstants.FONT_FAMILY,
                            fontSize: 14.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),*/

                //Add comment
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent,
                        blurRadius: 3.5,
                        spreadRadius: 0.4,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        S.of(context).addComment,
                        style: TextStyle(
                            fontFamily: AppConstants.FONT_FAMILY,
                            fontSize: 15.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                      ),
                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: CommonColors.primaryColor)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: TextFormField(
                            controller: _commentController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                fontFamily: AppConstants.FONT_FAMILY,
                                fontSize: 14.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),

                // Apply coupon code
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent,
                        blurRadius: 3.5,
                        spreadRadius: 0.4,
                      )
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: CommonColors.primaryColor)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: TextFormField(
                              controller: _couponCodeController,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: S.of(context).couponCode),
                              style: TextStyle(
                                  fontFamily: AppConstants.FONT_FAMILY,
                                  fontSize: 14.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // On Apply coupon code click
                          mViewModel.applyCouponCode(_couponCodeController.text, onMessage: (String message){
                            CommonUtils.showSnackBar(message, _globalKey);
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          margin: EdgeInsets.only(left: 8),
                          color: CommonColors.primaryColor,
                          child: Center(
                            child: Text(
                              S.of(context).apply.toUpperCase(),
                              style: TextStyle(
                                  fontFamily: AppConstants.FONT_FAMILY,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        footerView
      ],
    );

    return Scaffold(
      key: _globalKey,
        appBar: _appbar,
        backgroundColor: CommonColors.color_f5f5f5,
        body: mViewModel.isApiLoading
            ? ShimmerProductDetails()
            : mViewModel.isDetailsAvailable
                ? mBody
                : NoDataAvailableView(
                    image: LocalImages.ilustrasiCart,
                    message: S.of(context).cartNoItem));
  }

  StartTime() async {
    return Timer(Duration(milliseconds: 2000), navigator);
  }

  /// Navigation to route after user succes payment
  void navigator() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (_, __, ___) => new bottomNavigationBar()));
  }

  /// Card Popup if success payment
  _showDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: SimpleDialog(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
            color: Colors.white,
            child: Image.asset(
              LocalImages.checkList,
              height: 110.0,
              color: Colors.lightGreen,
            ),
          ),
          Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 23.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppConstants.FONT_FAMILY_GOTIK,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
