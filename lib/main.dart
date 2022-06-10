import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harmis_opencart/app.dart';
import 'package:provider/provider.dart';

void main() async {

  Provider.debugCheckInvalidValueType = null;

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(App());

}
