import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/views/order_details/order_details_view_model.dart';
import 'package:provider/provider.dart';

class OrderDetailsView extends StatefulWidget {
  String orderId = "";

  OrderDetailsView(this.orderId);

  @override
  _OrderDetailsViewState createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      Provider.of<OrderDetailsViewModel>(context).orderDetails(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mViewModel = Provider.of<OrderDetailsViewModel>(context);

    final addressTitle = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text(
              S.of(context).deliveryAddress,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: AppConstants.FONT_FAMILY,
                  fontSize: 15.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
          )
        ]);

    final updateToSent = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text(
              S.of(context).updateSentTo,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: AppConstants.FONT_FAMILY,
                  fontSize: 15.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
          )
        ]);

    final addressFull = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text(
              mViewModel.orderHistoryDetails?.shipAdderss1 ?? "",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: AppConstants.FONT_FAMILY,
                  fontSize: 15.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
          )
        ]);

    final thank_you =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Flexible(
        flex: 1,
        child: Text(
          S.of(context).thank_you,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: AppConstants.FONT_FAMILY,
              fontSize: 15.0,
              color: Colors.black87,
              fontWeight: FontWeight.w500),
        ),
      )
    ]);

    final placeOnOder = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).placeOn,
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
            mViewModel.orderHistoryDetails?.placeOn ?? "",
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

    final orderNo = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).orderNo,
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
            mViewModel.orderHistoryDetails?.orderNo ?? "",
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

    final invoice = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).invoice,
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
            mViewModel.orderHistoryDetails?.invoice ?? "",
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

    final paymentMethod = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).paymentMethod,
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
            mViewModel.orderHistoryDetails?.paymentMethod ?? "",
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

    final email = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).email,
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
            mViewModel.orderHistoryDetails?.email ?? "",
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

    final ordeStatus = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).orderStatus,
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
            mViewModel.orderHistoryDetails?.statusName ?? "",
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

    final affiliate = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            S.of(context).affiliate,
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
            mViewModel.orderHistoryDetails?.affiliate ?? "",
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

    final thanksMessage = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text(
              S.of(context).thanksMessage,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: AppConstants.FONT_FAMILY,
                  fontSize: 15.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
          )
        ]);

    final orderHistory = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.message),
                  Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Text(
                      S.of(context).orderStatus,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: AppConstants.FONT_FAMILY,
                          fontSize: 15.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              )),
          Icon(Icons.arrow_forward_ios),
        ]);

    final update = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.message),
                  Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Text(mViewModel.orderHistoryDetails?.phone?? "",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: AppConstants.FONT_FAMILY,
                          fontSize: 15.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              )),
        ]);

    final mBody = Stack(
      children: <Widget>[
        Padding(
            padding:
                EdgeInsets.only(bottom: 60, left: 8.0, right: 8.0, top: 8.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 12, bottom: 12),
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
                        thanksMessage,
                        Padding(
                          padding: EdgeInsets.only(top: 18.0),
                        ),
                        thank_you,
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 12, bottom: 12),
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
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        placeOnOder,
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        orderNo,
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Divider(
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 12, bottom: 12),
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
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        invoice,
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        paymentMethod,
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        email,
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        ordeStatus,
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        affiliate,
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 12, bottom: 12),
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
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        addressTitle,
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        addressFull,
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 12, bottom: 12),
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
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        updateToSent,
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        update,
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 12, bottom: 12),
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
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        orderHistory,
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
      ],
    );

    return Scaffold(
      backgroundColor: CommonColors.color_f5f5f5,
      key: globalKey,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop(false);
            },
            child: Icon(Icons.arrow_back)),
        elevation: 0.0,
        title: Text(
          S.of(context).orderDetails,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.white,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: mBody,
    );
  }
}
