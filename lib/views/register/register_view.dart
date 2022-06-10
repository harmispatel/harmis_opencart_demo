import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:harmis_opencart/database/app_preferences.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/utils/local_images.dart';
import 'package:harmis_opencart/views/login/login_animation.dart';
import 'package:harmis_opencart/views/login/login_view.dart';
import 'package:harmis_opencart/views/login/login_view_model.dart';
import 'package:harmis_opencart/widgets/button/back_custom_button.dart';
import 'package:harmis_opencart/widgets/textfield/textform_custom.dart';
import 'package:provider/provider.dart';

class RegisteView extends StatefulWidget {
  @override
  _RegisteViewState createState() => _RegisteViewState();
}

class _RegisteViewState extends State<RegisteView> {
  final mFirstNameController = TextEditingController();
  final mLastNameController = TextEditingController();
  final mPhoneController = TextEditingController();
  final mEmailController = TextEditingController();
  final mPasswordController = TextEditingController();

  AnimationController sanimationController;
  AnimationController animationControllerScreen;
  Animation animationScreen;

  var tap = 0;
  bool isChecked = false;

  final globalKey = GlobalKey<ScaffoldState>();

  void _snackBar(String text, context) {
    final snackBar =
        SnackBar(content: Text(S.of(context).welcome + ' ${text} !'));
    globalKey.currentState.showSnackBar(snackBar);
  }


  void _welcomeMessage(user, context) {

    final snackBar = SnackBar(content: Text(S.of(context).welcome + ' ${user} !'));
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
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.height;
    mediaQueryData.size.width;

    _submitRegister(context) async {
      if (mFirstNameController.text.isEmpty ||
          mLastNameController.text.isEmpty ||
          mPhoneController.text.isEmpty ||
          mEmailController.text.isEmpty ||
          mPasswordController.text.isEmpty) {
        _snackBar("Please input fill in all fields", context);
      } else {
        Provider.of<LoginViewModel>(context).createUser(
          firstName: mFirstNameController.text.trim(),
          lastName: mLastNameController.text.trim(),
          email: mEmailController.text.trim(),
          password: mPasswordController.text.trim(),
          phone: mPasswordController.text.trim(),
          success: (user) {
            LoginMaster user1 = user as LoginMaster;
            if (user1.success == 1) {
              AppPreferences appSettings = new AppPreferences();
              appSettings.setLoginDetails(json.encode(user1.result.toJson()));
              appSettings.setLoggedIn(isLoggedIn: true);
              /*Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new TabBarView(children: null)));*/
              //Navigator.pushReplacementNamed(context, AppRoutes.APP_ROUTE_HOME);
              Navigator.pop(context, {
                AppConstants.LOGIN_DETAILS: "1",
              });
              _welcomeMessage(user1.result.firstName, context);
            } else {
              _failMessage(user1.message, context);
            }
          },
          fail: (message) => _failMessage(message, context),
        );
      }
    }

    final mBody = Stack(
      children: <Widget>[
        Container(
          /// Set Background image in layout
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(LocalImages.register_back),
            fit: BoxFit.cover,
          )),
          child: Container(
            /// Set gradient color in image
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.2),
                  Color.fromRGBO(0, 0, 0, 0.3)
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              ),
            ),

            /// Set component layout
            child: ListView(
              padding: EdgeInsets.all(0.0),
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0)),

                                  /// Animation text treva shop accept from login layout
                                  Text(
                                    S.of(context).title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0.6,
                                        fontFamily: AppConstants.FONT_FAMILY,
                                        color: Colors.white,
                                        fontSize: 20.0),
                                  ),
                                ],
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0)),

                              /// TextFromField First Name
                              textFromField(
                                icon: Icons.account_circle,
                                password: false,
                                email: S.of(context).firstname,
                                inputType: TextInputType.text,
                                controller: mFirstNameController,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0)),

                              /// TextFromField Lastname
                              textFromField(
                                icon: Icons.account_circle,
                                password: false,
                                email: S.of(context).lastName,
                                inputType: TextInputType.text,
                                controller: mLastNameController,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0)),

                              /// TextFromField Phone
                              textFromField(
                                icon: Icons.phone_android,
                                password: false,
                                email: S.of(context).phone,
                                inputType: TextInputType.number,
                                controller: mPhoneController,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0)),

                              /// TextFromField Email
                              textFromField(
                                icon: Icons.email,
                                password: false,
                                email: S.of(context).email,
                                inputType: TextInputType.emailAddress,
                                controller: mEmailController,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0)),

                              /// TextFromField Password
                              textFromField(
                                icon: Icons.vpn_key,
                                password: true,
                                email: S.of(context).password,
                                inputType: TextInputType.text,
                                controller: mPasswordController,
                              ),

                              /// Button Login
                              FlatButton(
                                  padding: EdgeInsets.only(top: 20.0),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new LoginView()));
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
                                    top: mediaQueryData.padding.top + 80.0,
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
                              print("Helloo");
                              _submitRegister(context);
                            },
                            child: buttonBlackBottom(
                              title: S.of(context).signUp,
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
        ),
      ],
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
