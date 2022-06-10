import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/product.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/constant.dart';

class ProductItem extends StatelessWidget {
  ProductSingle item;
  GestureTapCallback productTap;
  GestureTapCallback addToCartTap;

  ProductItem({this.item, this.productTap, this.addToCartTap});

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return InkWell(
      onTap: productTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 2.0,
                spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
              )
            ]),
        child: Wrap(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 190,//mediaQueryData.size.height / 3.3,
                  width: 200.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.0),
                          topRight: Radius.circular(7.0)),
                      image: DecorationImage(
                          image: NetworkImage(item.thumbImage),
                          fit: BoxFit.cover)),
                ),
                Padding(padding: EdgeInsets.only(top: 7.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    item.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.black54,
                        fontFamily: AppConstants.FONT_FAMILY,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 1.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    item.currencyCode + " " + item.price,
                    style: TextStyle(
                        fontFamily: AppConstants.FONT_FAMILY,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 15.0,bottom: 15),
                      child: InkWell(
                        onTap: addToCartTap,
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(22.5)),
                            color: CommonColors.primaryColor,
                          ),
                          child: Center(
                            child: Icon(Icons.add_shopping_cart,
                              color: Colors.white,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}
