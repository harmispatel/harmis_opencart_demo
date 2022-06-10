import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';

class SearchHelloView extends StatefulWidget {
  @override
  _SearchHelloViewState createState() => _SearchHelloViewState();
}

class _SearchHelloViewState extends State<SearchHelloView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50.0, left: 20.0,top: 20),
      child: Text(
        S.of(context).searchHello,
        style: TextStyle(
            letterSpacing: 0.1,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
            color: Colors.black54,
            fontFamily: "Gotik"),
      ),
    );
  }
}
