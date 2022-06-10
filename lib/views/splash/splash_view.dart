
import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/app.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/utils/local_images.dart';
import 'package:harmis_opencart/views/login/login_view.dart';
import 'package:harmis_opencart/views/splash/splash_view_model.dart';
import 'package:harmis_opencart/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashView> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppModel>(context).changeLanguage();
      Provider.of<SplashViewModel>(context).startTimer(context);
    });
  }


void redirectToHome() {
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (BuildContext context) =>
          new LoginView()));
}

  @override
  Widget build(BuildContext context) {
    final mViewModel = Provider.of<SplashViewModel>(context);

    final mBody = Container();

    return Scaffold(
      backgroundColor: CommonColors.primaryColor,
      body: Container(
        /// Set Background image in splash screen layout (Click to open code)
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(LocalImages.splash), fit: BoxFit.cover)),
        child: Container(
          /// Set gradient black in image splash screen (Click to open code)
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.3),
                    Color.fromRGBO(0, 0, 0, 0.4)
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter)),
          child: Builder(
            builder: (BuildContext _buildContext) {
              return mBody;
            },
          ),
        ),
      ),
    );
  }
}