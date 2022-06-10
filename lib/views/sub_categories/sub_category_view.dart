import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/views/home/category_item.dart';
import 'package:harmis_opencart/views/products/product_view.dart';
import 'package:harmis_opencart/views/sub_categories/sub_category_view_model.dart';
import 'package:harmis_opencart/widgets/shimmer_view/ShimmerGridList.dart';
import 'package:provider/provider.dart';

class SubCategoryView extends StatefulWidget {

  String catId = "";
  String catName = "";


  SubCategoryView({this.catId, this.catName});

  @override
  _SubCategoryViewState createState() => _SubCategoryViewState( );
}

class _SubCategoryViewState extends State<SubCategoryView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState( );
    Future.delayed( Duration.zero, () {
      Provider.of<SubCategoryViewModel>( context ).getSubCategories(
          widget.catId);
    } );
  }

  @override
  Widget build(BuildContext context) {

    final mViewModel = Provider.of<SubCategoryViewModel>(context);
    /// Grid Item a product
    var _grid = mViewModel.imageLoad
        ? ShimmerGridList()
        : NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            if (mViewModel.categoryStartLimit < mViewModel.categoryTotalCount &&
                !mViewModel.categoryIsApiLoading) {
              mViewModel.categoryStartLimit += 10;
              Provider.of<SubCategoryViewModel>( context ).getSubCategories(widget.catId);
            }
          }
        },
        child: GridView.count(
          shrinkWrap: true,
          padding:
          EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 0.545,
          crossAxisCount: 2,
          primary: false,
          children: List.generate(
            /// Get data in flashSaleItem.dart (ListItem folder)
            (mViewModel.categoryIsApiLoading)
                ? mViewModel.categoryList.length + 1
                : mViewModel.categoryList.length,
                (index) => (index == mViewModel.categoryList.length)
                ? CommonUtils.getListItemProgressBar()
                : CategoryItemValue(
              category: mViewModel.categoryList[index],
              tap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                    mViewModel.categoryList[index].hasSubCategory == 1
                        ? new SubCategoryView(catId: mViewModel.categoryList[index].catId)
                        : new ProductView(
                        mViewModel.categoryList[index].name,
                        mViewModel.categoryList[index].catId, false),
                    transitionDuration:
                    Duration(milliseconds: 750),
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
            ),
          ),
        ));

    return Scaffold(
      /// Appbar item
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).subCategory,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Colors.white,
              fontFamily: "Gotik"),
        ),

        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CommonColors.primaryColor,
        elevation: 0.0,
      ),
      body: _grid,
    );
  }
}
