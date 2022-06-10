import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/views/my_orders/my_orders_item.dart';
import 'package:harmis_opencart/views/my_orders/my_orders_view_model.dart';
import 'package:harmis_opencart/widgets/shimmer_view/shimmer_cart_list.dart';
import 'package:provider/provider.dart';

class MyOrdersView extends StatefulWidget {
  @override
  _MyOrdersViewState createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<MyOrdersViewModel>(context).ordersStartLimit = 0;
      Provider.of<MyOrdersViewModel>(context).ordersTotalCount = 0;
      Provider.of<MyOrdersViewModel>(context).myOrders();
    });
  }

  @override
  Widget build(BuildContext context) {

    final mViewModel = Provider.of<MyOrdersViewModel>(context);

    final mBody = Container(
      color: Colors.white,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            if (mViewModel.ordersStartLimit < mViewModel.ordersTotalCount &&
                !mViewModel.ordersApiLoading) {
              mViewModel.ordersStartLimit += 10;
              Provider.of<MyOrdersViewModel>(context).myOrders();
            }
          }
        },
        child: CustomScrollView(
          /// Create List Menu
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.only(top: 0.0),
              sliver: SliverFixedExtentList(
                  itemExtent: 145.0,
                  delegate: SliverChildBuilderDelegate(
                    /// Calling itemCard Class for constructor card
                          (context, index) => (index ==
                          mViewModel.ordersDetailsList.length)
                          ? CommonUtils.getListItemProgressBar()
                          : MyOrderItem(mViewModel.ordersDetailsList[index]),
                      childCount: (mViewModel.ordersApiLoading)
                          ? mViewModel.ordersDetailsList.length + 1
                          : mViewModel.ordersDetailsList.length)),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop(false);
            },
            child: Icon(Icons.arrow_back)),
        elevation: 0.0,
        title: Text(
          S.of(context).myOrders,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.white,
              fontFamily: AppConstants.FONT_FAMILY_GOTIK),
        ),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: mViewModel.isShimmer ? ShimmerCartList() : mBody,
    );
  }
}
