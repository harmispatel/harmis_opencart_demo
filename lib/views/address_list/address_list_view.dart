import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/brand.dart';
import 'package:harmis_opencart/models/cart.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/utils/local_images.dart';
import 'package:harmis_opencart/views/add_address/add_address_view.dart';
import 'package:harmis_opencart/views/address_list/address_list_view_model.dart';
import 'package:harmis_opencart/views/brand/brand_view_model.dart';
import 'package:harmis_opencart/views/cart/no_cart_view.dart';
import 'package:harmis_opencart/views/order_summary/order_summary_view.dart';
import 'package:harmis_opencart/views/products/product_view.dart';
import 'package:harmis_opencart/widgets/shimmer_view/shimmer_address_list.dart';
import 'package:harmis_opencart/widgets/shimmer_view/shimmer_cart_list.dart';
import 'package:provider/provider.dart';

class AddressListView extends StatefulWidget {
  CartMaster cartMaster;
  String fromScreen = "";

  AddressListView(this.fromScreen, {this.cartMaster});

  @override
  _AddressListViewState createState() => _AddressListViewState();
}

class _AddressListViewState extends State<AddressListView> {
  final _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AddressListViewModel>(context).getAddressList();
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double size = mediaQueryData.size.height;

    final mViewModel = Provider.of<AddressListViewModel>(context);

    /// Component appbar
    var _appbar = AppBar(
        backgroundColor: CommonColors.primaryColor,
        elevation: 0.0,
        actions: <Widget>[
          InkWell(
              onTap: () {
                // Add address click
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        AddAddressView(
                          isEdit: false,
                        )));
              },
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 28.0,
                ),
              ))
        ],
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Text(
            S
                .of(context)
                .address,
            style: TextStyle(
                fontFamily: AppConstants.FONT_FAMILY_GOTIK,
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ));

    final mBody = Container(
      child: Stack(
        children: <Widget>[
          mViewModel.addressList.length > 0
              ? ListView.builder(
            itemCount: mViewModel.addressList.length,
            itemBuilder: (context, position) {
              return Slidable(
                delegate: new SlidableDrawerDelegate(),
                actionExtentRatio: 0.25,
                actions: <Widget>[
                  new IconSlideAction(
                    caption: S
                        .of(context)
                        .edit,
                    color: CommonColors.primaryBlue,
                    icon: Icons.edit,
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              AddAddressView(
                                isEdit: true,
                                addressDetails: mViewModel
                                    .addressList[position],
                              )));
                    },
                  ),
                ],
                secondaryActions: <Widget>[
                  new IconSlideAction(
                    key: Key(mViewModel.addressList[position].addressId
                        .toString()),
                    caption: S
                        .of(context)
                        .cartDelete,
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      mViewModel.deleteAddress(
                          mViewModel.addressList[position].addressId);
                    },
                  ),
                ],
                child: InkWell(
                  onTap: () {
                    // On address click
                    mViewModel.selectAddress(position);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 13.0, right: 13.0),

                    /// Background Constructor for card
                    child: Container(
//                      height: size,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              widget.fromScreen ==
                                  AppConstants.SETTINGS_SCREEN
                                  ? Container()
                                  : Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(
                                  mViewModel.addressList[position]
                                      .isSelected
                                      ? Icons.radio_button_checked
                                      : Icons
                                      .radio_button_unchecked,
                                  color: CommonColors.primaryColor,
                                  size: 28.0,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, left: 15.0, right: 5.0),
                                  child: Column(

                                    /// Text Information Item
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${mViewModel.addressList[position]
                                            .firstName + " " +
                                            mViewModel.addressList[position]
                                                .lastName}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily:
                                          AppConstants.FONT_FAMILY,
                                          color: Colors.black87,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Padding(
                                          padding:
                                          EdgeInsets.only(top: 10.0)),
                                      Text(
                                        '${mViewModel.addressList[position]
                                            .fullAddress}',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.0,
                                        ),
                                      ),
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
              );
            },
            scrollDirection: Axis.vertical,
          )
              : Container(),
          widget.fromScreen == AppConstants.SETTINGS_SCREEN
              ? Container()
              : Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                if (mViewModel.checkValidation()) {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          OrderSummaryView(
                              widget.cartMaster,
                              mViewModel.selectedAddress)));
                } else {
                  CommonUtils.showSnackBar(S
                      .of(context)
                      .chooseAddress, _globalKey);
                }
                // On Place order click
              },
              child: Container(
                width: double.infinity,
                height: 50,
                color: CommonColors.primaryColor,
                child: Center(
                  child: Text(
                    S
                        .of(context)
                        .next,
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
    );
    return Scaffold(
        key: _globalKey,
        appBar: _appbar,
        body: mViewModel.isApiLoading
            ? ShimmerCartList()
            : mViewModel.isDetailsAvailable
            ? mBody
            : NoDataAvailableView(
            image: LocalImages.ilustrasiCart,
            message: S
                .of(context)
                .cartNoItem));
  }
}
