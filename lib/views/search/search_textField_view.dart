import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';

class SearchTextFieldView extends StatelessWidget {

  var onChanged;

  SearchTextFieldView(this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0, right: 20.0, left: 20.0),
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
              child: TextField(
                onChanged: onChanged,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.search,
                      color: Color(0xFF6991C7),
                      size: 28.0,
                    ),
                    hintText:
                    S.of(context).findYouWant,
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
  }
}
