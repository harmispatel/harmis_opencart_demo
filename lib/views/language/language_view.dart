import 'package:flutter/material.dart';

class LanguageView extends StatelessWidget {
  String title,flag;
  LanguageView({this.title,this.flag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 20.0),
      child: Container(
        height: 80.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.0,
                  spreadRadius: 0.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left:20.0,right: 15.0),
          child: Row(children: <Widget>[
            Image.asset(flag,fit: BoxFit.cover,height: 65.0,),
            Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20.0),
              child: Text(title,style: TextStyle(fontFamily: "Popins",fontSize: 16.0,fontWeight: FontWeight.w500,letterSpacing: 1.3),),
            )]),
        ),
      ),
    );
  }
}