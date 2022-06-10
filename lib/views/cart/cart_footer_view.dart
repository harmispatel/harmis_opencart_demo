import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/cart.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/views/address_list/address_list_view.dart';

class CartFooterView extends StatelessWidget {
  CartMaster cart;

  CartFooterView({this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 9.0, left: 10.0, right: 10.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0),

              /// Total price of item buy
              child: Text(
                S.of(context).cartTotal +
                    " : " +
                    cart.currencyCode +
                    " " +
                    cart.total,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.5,
                    fontFamily: AppConstants.FONT_FAMILY),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => AddressListView(AppConstants.CART_SCREEN, cartMaster: cart,)));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  height: 40.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    color: CommonColors.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      S.of(context).cartPay,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppConstants.FONT_FAMILY,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
