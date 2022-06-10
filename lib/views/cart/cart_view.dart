import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/app.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/utils/local_images.dart';
import 'package:harmis_opencart/views/cart/cart_footer_view.dart';
import 'package:harmis_opencart/views/cart/cart_view_model.dart';
import 'package:harmis_opencart/views/cart/no_cart_view.dart';
import 'package:harmis_opencart/widgets/shimmer_view/shimmer_cart_list.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<CartViewModel>(context).getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);

    final mBody = Container(
      child: (Stack(
        children: <Widget>[
          cartViewModel.isDataAvailable
              ? Container(
                  margin: EdgeInsets.only(bottom: 70.0),
                  child: ListView.builder(
                    itemCount: cartViewModel.cartList.length,
                    itemBuilder: (context, position) {
                      return Slidable(
                        delegate: new SlidableDrawerDelegate(),
                        actionExtentRatio: 0.25,
                        actions: <Widget>[
                          new IconSlideAction(
                            caption: S.of(context).cartArchiveText,
                            color: Colors.blue,
                            icon: Icons.archive,
                            onTap: () {
                              ///
                              /// SnackBar show if cart Archive
                              ///
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(S.of(context).cartArchice),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.blue,
                              ));
                            },
                          ),
                        ],
                        secondaryActions: <Widget>[
                          new IconSlideAction(
                            key: Key(cartViewModel.cartList[position].productId
                                .toString()),
                            caption: S.of(context).cartDelete,
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              cartViewModel.deleteProductCart(
                                  productId: cartViewModel
                                      .cartList[position].productId,
                                  referenceId: cartViewModel
                                      .cartList[position].referenceId,
                                  success: (String qty) {
                                    if (qty != null) {
                                      Provider.of<AppModel>(context).CountNotice = qty;
                                      Provider.of<AppModel>(context).notifyListeners();
                                    }
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(S.of(context).cartDeleted),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.redAccent,
                                    ));
                                  });
                            },
                          ),
                        ],
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 13.0, left: 13.0, right: 13.0),

                          /// Background Constructor for card
                          child: Container(
                            height: 190.0,
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
                                                color: Colors.white
                                                    .withOpacity(0.1),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black12
                                                          .withOpacity(0.1),
                                                      blurRadius: 0.5,
                                                      spreadRadius: 0.1)
                                                ]),
                                            child: Image.network(
                                              '${cartViewModel.cartList[position].thumbImage}',
                                              height: 130.0,
                                              width: 120.0,
                                              fit: BoxFit.cover,
                                            ))),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25.0, left: 10.0, right: 5.0),
                                        child: Column(
                                          /// Text Information Item
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${cartViewModel.cartList[position].name}',
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
                                              '${cartViewModel.cartList[position].category}',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10.0)),
                                            Text(
                                                '${cartViewModel.cartList[position].price}'),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18.0, left: 0.0),
                                              child: Container(
                                                width: 112.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    border: Border.all(
                                                        color: Colors.black12
                                                            .withOpacity(0.1))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    /// Decrease of value item
                                                    InkWell(
                                                      onTap: () {
                                                        int quantity = int
                                                            .parse(cartViewModel
                                                                .cartList[
                                                                    position]
                                                                .quantity);

                                                        if (quantity > 1) {
                                                          cartViewModel.updateCart(
                                                              cartViewModel
                                                                  .cartList[
                                                                      position]
                                                                  .productId,
                                                              "1",
                                                              "2");
                                                        }
                                                        print("Minus");
                                                      },
                                                      child: Container(
                                                        height: 30.0,
                                                        width: 30.0,
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                right: BorderSide(
                                                                    color: Colors
                                                                        .black12
                                                                        .withOpacity(
                                                                            0.1)))),
                                                        child: Center(
                                                            child: Text("-")),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 18.0),
                                                      child: Text(
                                                          '${cartViewModel.cartList[position].quantity}'), //Text(value.toString()),
                                                    ),

                                                    /// Increasing value of item
                                                    InkWell(
                                                      onTap: () {
                                                        cartViewModel.updateCart(
                                                            cartViewModel
                                                                .cartList[
                                                                    position]
                                                                .productId,
                                                            "1",
                                                            "1");
                                                        print("Plus");
//                                                  setState(() {
//                                                    value = value + 1;
//                                                    pay = 950 * value;
//                                                  });
                                                      },
                                                      child: Container(
                                                        height: 30.0,
                                                        width: 28.0,
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                left: BorderSide(
                                                                    color: Colors
                                                                        .black12
                                                                        .withOpacity(
                                                                            0.1)))),
                                                        child: Center(
                                                            child: Text("+")),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                      );
                    },
                    scrollDirection: Axis.vertical,
                  ),
                )
              : NoDataAvailableView(
                  image: LocalImages.ilustrasiCart,
                  message: S.of(context).cartNoItem,
                ),
          cartViewModel.cartList.length > 0
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: CartFooterView(
                    cart: cartViewModel.cart,
                  ),
                )
              : Container()
        ],
      )),
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
        title: Text(
          S.of(context).cart,
          style: TextStyle(
              fontFamily: "Gotik",
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
        elevation: 0.0,
      ),
      body: cartViewModel.loading ? ShimmerCartList() : mBody,
      //body: noCartItemCart(),
    );
  }
}
