
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:harmis_opencart/models/categories.dart';
import 'package:html/dom.dart' as dom;

class CategoryItemValue extends StatelessWidget {

  CategoriesDetails category;
  GestureTapCallback tap;

  CategoryItemValue({
    this.category,
    this.tap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        height: 105.0,
        width: 160.0,
        margin: EdgeInsets.only(left: 6, right: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          image: DecorationImage(
              image: NetworkImage(category.thumbImage), fit: BoxFit.contain),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            color: Colors.black.withOpacity(0.25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Html(
                data: category.name,
                customTextAlign: (dom.Node node) {
                  return TextAlign.center;
                },
                defaultTextStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: "Berlin",
                  fontSize: 18.5,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
