import 'dart:math';

import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/user.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/views/account/account_view_model.dart';
import 'package:harmis_opencart/views/profile/profile_header_view.dart';
import 'package:harmis_opencart/views/profile/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart' as prefix0;

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final globalKey = GlobalKey<ScaffoldState>();

  LoginDetails loginDetails;

  String password, confirmPassword;

  final mFirstController = TextEditingController( );
  final mLastnamePasswordController = TextEditingController( );
  final mEmailController = TextEditingController( );
  final mPhoneController = TextEditingController( );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ProfileViewModel>(context).getUserDetails();
      final mViewModel = Provider.of<AccountViewModel>(context);
      mFirstController.text = mViewModel.loginDetails.firstName ?? "";
      mLastnamePasswordController.text = mViewModel.loginDetails.lastName ?? "";
      mEmailController.text = mViewModel.loginDetails.email ?? "";
      mPhoneController.text = mViewModel.loginDetails.phone ?? "";
      //Foo({Bar bar}) : bar = bar ?? Bar();
    });
  }

  @override
  Widget build(BuildContext context) {

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
          S.of(context).profile,
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                ProfileImageView(),
                TextFormField(
                  controller: mFirstController,
                  decoration: InputDecoration(
                      labelText: S.of(context).firstname,
                      hintText: S.of(context).firstname,
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  controller: mLastnamePasswordController,
                  decoration: InputDecoration(
                      labelText: S.of(context).lastName,
                      hintText: S.of(context).lastName,
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  enabled: false,
                  controller: mEmailController,
                  decoration: InputDecoration(
                      labelText: S.of(context).email,
                      hintText: S.of(context).email,
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  controller: mPhoneController,
                  decoration: InputDecoration(
                      labelText: S.of(context).phone,
                      hintText: S.of(context).phone,
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
                Padding(padding: EdgeInsets.only(top: 80.0)),
                InkWell(
                  onTap: () {
                    // Update profile api
                    _updateProfile(context);
                  },
                  child: Container(
                    height: 55.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black38, blurRadius: 15.0)
                        ],
                        gradient: LinearGradient(colors: <Color>[
                          CommonColors.primaryColor,
                          CommonColors.PrimaryDarkColor
                        ]),
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Center(
                      child: Text(
                        S.of(context).save,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.5,
                            letterSpacing: 1.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _updateProfile(context) {
    if (mFirstController.text.isEmpty ||
        mLastnamePasswordController.text.isEmpty ||
        mEmailController.text.isEmpty || mPhoneController.text.isEmpty) {
      var snackBar = SnackBar( content: Text( S
          .of( context )
          .pleaseInput ) );
      globalKey.currentState.showSnackBar( snackBar );
    } else {
      Provider.of<ProfileViewModel>(context).updateProfileApiCall(
          fname: mFirstController.text.toString(),
          lname: mLastnamePasswordController.text.toString(),
          email: mEmailController.text.toString(),
          phone: mPhoneController.text.toString(),
        success: (String message){
            print("dfdhfd");
            CommonUtils.showSnackBar(message, globalKey);
        }
      );
    }
  }
}
