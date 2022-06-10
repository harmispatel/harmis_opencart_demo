import 'package:flutter/material.dart';
import 'package:harmis_opencart/models/categories.dart';
import 'package:harmis_opencart/models/product.dart';
import 'package:harmis_opencart/models/product_test.dart';
import 'package:harmis_opencart/utils/local_images.dart';
import 'package:harmis_opencart/views/product_details/product_details_view.dart';
import 'package:harmis_opencart/views/products/product_view.dart';
import 'package:harmis_opencart/views/sub_categories/sub_category_view.dart';

/// ItemGrid in bottom item "Recomended" item
///
class RecommedItemGrid extends StatelessWidget {
  /// Get data from HomeGridItem.....dart class
  CategoriesDetails productItem;

  RecommedItemGrid(this.productItem);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return InkWell(
      onTap: () {
        print("tapped");

        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
            productItem.hasSubCategory == 1
                    ? new SubCategoryView(
                        catId: productItem.catId,
                        catName: productItem.name,
                      )
                    : new ProductView(productItem.name,
                productItem.catId, false),
            transitionDuration: Duration(milliseconds: 750),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            }));

//        Navigator.of(context).push(PageRouteBuilder(
//            pageBuilder: (_, __, ___) => ProductDetailsView(
//                  productId: productItem.catId,
//                ),
//            transitionDuration: Duration(milliseconds: 750),
//            transitionsBuilder:
//                (_, Animation<double> animation, __, Widget child) {
//              return Opacity(
//                opacity: animation.value,
//                child: child,
//              );
//            }));
      },
      child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                            image: NetworkImage(productItem.thumbImage),
                            fit: BoxFit.contain)),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 7.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                    width: 150,
                    child: Text(
                      productItem.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          letterSpacing: 0.5,
                          color: Colors.black54,
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 1.0)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
