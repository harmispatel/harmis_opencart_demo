import 'package:flutter/material.dart';
import 'package:harmis_opencart/comman/tools.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/orders.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/views/order_details/order_details_view.dart';
import 'package:intl/intl.dart';


class MyOrderItem extends StatefulWidget {
  /// Declaration and Get data from BrandDataList.dart
  final OrderDetails order;

  MyOrderItem(this.order);

  _itemCardState createState() => _itemCardState(order);
}

class _itemCardState extends State<MyOrderItem> {
  final OrderDetails brand;

  _itemCardState(this.brand);

  DateTime timeStamp;
  DateTime ordeDate;

  var dateFormate;

  @override
  void initState() {
    super.initState();
    timeStamp = DateTime.fromMillisecondsSinceEpoch(int.parse(brand.orderDate) * 1000);
    dateFormate = DateFormat("dd-MM-yyyy").format(DateTime.parse(timeStamp.toString()));
  }

  @override
  Widget build(BuildContext context) {


    final rightSection = new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(dateFormate,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  fontFamily: AppConstants.FONT_FAMILY,
                  color: Colors.brown,
                ),),
            ),

          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(S.of(context).currencyIcone + " " + brand.totalPrice,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  fontFamily: AppConstants.FONT_FAMILY,
                  color: Colors.green,
                ),),
            ),

          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => OrderDetailsView(brand.orderNo),
              transitionDuration: Duration(milliseconds: 750),
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: child,
                );
              }));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 3.5,
                spreadRadius: 0.4,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Container(
                        height: 80,
                        width: 80,
                        color: CommonColors.primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              S.of(context).orderNo + "\n" + brand.orderNo,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: AppConstants.FONT_FAMILY,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, left: 15.0, right: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(brand.quantity + " " + S.of(context).items,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            fontFamily: AppConstants.FONT_FAMILY,
                            color: Colors.black,
                          )),
                      Padding(padding: EdgeInsets.only(top: 8.0)),
                      Text(brand.statusName?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: AppConstants.FONT_FAMILY,
                            color: HexColor(brand.statusColor?? "#FF0000"),
                          )),
                      Padding(padding: EdgeInsets.only(top: 8.0)),
                      Text(S.of(context).placeOn + " " + dateFormate.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: AppConstants.FONT_FAMILY,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
              ),
              rightSection,
            ],
          ),
        ),
      ),
    );
  }
}
