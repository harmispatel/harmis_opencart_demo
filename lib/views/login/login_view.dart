import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/utils/local_images.dart';
import 'package:harmis_opencart/views/login/login_animation.dart';
import 'package:harmis_opencart/views/login/login_view_model.dart';
import 'package:harmis_opencart/views/register/register_view.dart';
import 'package:harmis_opencart/widgets/button/back_custom_button.dart';
import 'package:harmis_opencart/widgets/button/facebook_custom_button.dart';
import 'package:harmis_opencart/widgets/button/google_custome_button.dart';
import 'package:harmis_opencart/widgets/textfield/textform_custom.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final globalKey = GlobalKey<ScaffoldState>();

  String username, password;

  final mUsernameController = TextEditingController();
  final mPasswordController = TextEditingController();

  AnimationController sanimationController;

  var tap = 0;

  void _welcomeMessage(user, context) {
    final snackBar =
    SnackBar(content: Text(S.of(context).welcome + ' ${user} !'));
    globalKey.currentState.showSnackBar(snackBar);
  }

  void _failMessage(message, context) {
    /// Showing Error messageSnackBarDemo
    /// Ability so close message
    final snackBar = SnackBar(content: Text('Warning: $message'));
    globalKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final mViewModel = Provider.of<LoginViewModel>(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;

    _login(context) async {
      if (mUsernameController.text.isEmpty ||
          mPasswordController.text.isEmpty) {
        var snackBar = SnackBar(content: Text(S.of(context).pleaseInput));
        globalKey.currentState.showSnackBar(snackBar);
      } else {
        Provider.of<LoginViewModel>(context).login(
          username: mUsernameController.text.trim(),
          password: mPasswordController.text.trim(),
          success: (user) {
            LoginMaster user1 = user as LoginMaster;
            if (user1.success == 1) {
              AppPreferences appSettings = new AppPreferences();
              appSettings.setLoginDetails(json.encode(user1.result.toJson()));
              appSettings.setLoggedIn(isLoggedIn: true);
              //Navigator.pushReplacementNamed(context, AppRoutes.APP_ROUTE_HOME);
              _welcomeMessage(user1.result.firstName, context);
              Navigator.pop(context, {
                AppConstants.LOGIN_DETAILS: "1",
              });
            } else {
              _failMessage(user1.message, context);
            }
          },
          fail: (message) => _failMessage(message, context),
        );
      }
    }

    final mBody = Container(
      /// Set Background image in layout (Click to open code)
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(LocalImages.login_back),
            fit: BoxFit.cover,
          )),
      child: Container(
        /// Set gradient color in image (Click to open code)
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(0, 0, 0, 0.0),
              Color.fromRGBO(0, 0, 0, 0.3)
            ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
        ),

        /// Set component layout
        child: ListView(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      alignment: AlignmentDirectional.topCenter,
                      child: Column(
                        children: <Widget>[
                          /// padding logo
                          Padding(
                              padding: EdgeInsets.only(
                                  top: mediaQueryData.padding.top + 40.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage(LocalImages.logo),
                                height: 70.0,
                              ),
                              Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 10.0)),

                              /// Animation text treva shop accept from signup layout (Click to open code)
                              Text(
                                S.of(context).title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.6,
                                    color: CommonColors.PrimaryWhite,
                                    fontFamily: AppConstants.FONT_FAMILY,
                                    fontSize: 20.0),
                              ),
                            ],
                          ),

                          /// ButtonCustomFacebook
                          /*Padding(
                              padding: EdgeInsets.symmetric(vertical: 30.0)),
                          buttonCustomFacebook(),*/

                          /// ButtonCustomGoogle
                          Padding(padding: EdgeInsets.symmetric(vertical: 30.0)),
                          InkWell(onTap: () {
                            mViewModel.googleLogin(context);
                          }, child: buttonCustomGoogle()),

                          /// Set Text
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0)),
                          Text(
                            S.of(context).or,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 0.2,
                                fontFamily: AppConstants.FONT_FAMILY,
                                fontSize: 17.0),
                          ),

                          /// TextFromField Email
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0)),
                          textFromField(
                            icon: Icons.email,
                            password: false,
                            email: S.of(context).email,
                            inputType: TextInputType.emailAddress,
                            controller: mUsernameController,
                          ),

                          /// TextFromField Password
                          Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                          textFromField(
                            icon: Icons.vpn_key,
                            password: true,
                            email: S.of(context).password,
                            inputType: TextInputType.text,
                            controller: mPasswordController,
                          ),

                          /// Button Signup
                          FlatButton(
                              padding: EdgeInsets.only(top: 20.0),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                        new RegisteView()));
                              },
                              child: Text(
                                S.of(context).notHave,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppConstants.FONT_FAMILY),
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                top: mediaQueryData.padding.top + 100.0,
                                bottom: 0.0),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                /// Set Animaion after user click buttonLogin
                tap == 0
                    ? InkWell(
                  splashColor: Colors.yellow,
                  onTap: () {
                    _login(context);
                  },
                  child: buttonBlackBottom(
                    title: S.of(context).login,
                  ),
                )
                    : new LoginAnimation(
                  animationController: sanimationController.view,
                )
              ],
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      key: globalKey,
      body: Builder(
        builder: (BuildContext _buildContext) {
          return mBody;
        },
      ),
    );
  }
}
