import 'package:flutter/material.dart';
import 'package:harmis_opencart/models/best_seller.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/views/product_details/product_details_view.dart';

/// Item for best seller products
class ItemBestSeller extends StatelessWidget {
  /// Get data from HomeGridItem.....dart class
  BestSellerDetails bestSellerItem;

  ItemBestSeller(this.bestSellerItem);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => ProductDetailsView(productId: bestSellerItem.productId,),
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
        margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 4.0,
                spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
              )
            ]),
        child: Wrap(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /// Set Animation image to detailProduk layout
                Material(
                  child: Container(
                    height: 150,//mediaQueryData.size.height / 3.3,
                    width: 150.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7.0),
                            topRight: Radius.circular(7.0)),
                        image: DecorationImage(
                            image: NetworkImage(bestSellerItem.thumbImage),
                            fit: BoxFit.contain)),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 7.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                    width: 150,
                    child: Text(
                      bestSellerItem.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          letterSpacing: 0.5,
                          color: Colors.black54,
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 1.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    bestSellerItem.currencyCode + " " + bestSellerItem.price,
                    style: TextStyle(
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  ),
                ),
//                Padding(
//                  padding:
//                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
//                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Row(
//                        children: <Widget>[
//                          Text(
//                            "Ratings",
//                            style: TextStyle(
//                                fontFamily: "Sans",
//                                color: Colors.black26,
//                                fontWeight: FontWeight.w500,
//                                fontSize: 12.0),
//                          ),
//                          Icon(
//                            Icons.star,
//                            color: Colors.yellow,
//                            size: 14.0,
//                          )
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
