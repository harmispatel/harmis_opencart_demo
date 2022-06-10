import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/app.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/views/product_details/product_details_view.dart';
import 'package:harmis_opencart/views/products/product_item.dart';
import 'package:harmis_opencart/views/products/product_view_model.dart';
import 'package:harmis_opencart/views/search/search_hello_view.dart';
import 'package:harmis_opencart/views/search/search_view_item.dart';
import 'package:harmis_opencart/views/search/search_view_model.dart';
import 'package:harmis_opencart/widgets/shimmer_view/ShimmerGridList.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  ScrollController _controller = new ScrollController();


  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    print("Hello init bhavesh");
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      Provider.of<SearchViewModel>(context).startLimit = 0;
      Provider.of<SearchViewModel>(context).totalCount = 0;
      Provider.of<SearchViewModel>(context).productList.clear();

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {

    final mViewModel = Provider.of<SearchViewModel>(context);

    var _search = Padding(
      padding: const EdgeInsets.only(top: 35.0, right: 20.0, left: 20.0,bottom: 10),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15.0,
                  spreadRadius: 0.0)
            ]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                onChanged: (txt) {
                  mViewModel.searchText = txt.toString();
                  mViewModel.startLimit = 0;
                  mViewModel.getSearchProductListApi();
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.search,
                      color: Color(0xFF6991C7),
                      size: 28.0,
                    ),
                    hintText: S.of(context).findYouWant,
                    hintStyle: TextStyle(
                        color: Colors.black54,
                        fontFamily: "Gotik",
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),
        ),
      ),
    );


    var _grid = mViewModel.imageLoad
        ? ShimmerGridList()
        : NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          print("Hellooo load more");
          if (scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            if (mViewModel.startLimit < mViewModel.totalCount &&
                !mViewModel.isApiLoading) {
              mViewModel.startLimit += 10;
              Provider.of<SearchViewModel>(context)
                  .getSearchProductListApi();
            }
          }
        },
        child: ListView.builder(
          itemCount: (mViewModel.isApiLoading)
              ? mViewModel.productList.length + 1
              : mViewModel.productList.length,
          itemBuilder: (context, index) {
            return (index == mViewModel.productList.length)
                ? CommonUtils.getListItemProgressBar()
                : SearchItem(
              item: mViewModel.productList[index],
              productTap: () {

                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => ProductDetailsView(productId: mViewModel.productList[index].productId,),
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
              addToCartTap: () {
                mViewModel.updateCart(
                    context: context,
                    productId:
                    mViewModel.productList[index].productId,
                    quantity: mViewModel.productList[index].quantity,
                    success: (String message, String qty) {
                      Provider.of<AppModel>(context).CountNotice = qty;
                      Provider.of<AppModel>(context).notifyListeners();
                      CommonUtils.showSnackBar(message, globalKey);
                    },
                    fail: (String message) {
                      CommonUtils.showSnackBar(message, globalKey);
                    });
              },
            );
          },
          scrollDirection: Axis.vertical,
        ));

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
          S.of(context).search,
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
      body: Column(
          children: <Widget>[
            SearchHelloView(),
            _search,
            Expanded(
              child: _grid,
            ),
          ],
      ),

      /*SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// Caliing a variable
                SearchHelloView(),
                _search,
                _grid,
                Padding(padding: EdgeInsets.only(bottom: 30.0, top: 2.0))
              ],
            ),
          ),
        ),
      ),*/
    );
  }
}
