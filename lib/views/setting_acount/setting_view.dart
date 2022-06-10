import 'package:flutter/material.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/views/add_address/add_address_view.dart';
import 'package:harmis_opencart/views/address_list/address_list_view.dart';
import 'package:harmis_opencart/views/change_password/change_password_view.dart';
import 'package:harmis_opencart/views/profile/profile_view.dart';

class SettingView extends StatelessWidget {


  static var _txtCustomHead = TextStyle(
    color: Colors.black54,
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    fontFamily: "Gotik",
  );

  static var _txtCustomSub = TextStyle(
    color: Colors.black38,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Gotik",
  );

  String head, sub1, sub2, sub3;

  SettingView({this.head, this.sub1, this.sub2, this.sub3});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        height: 235.0,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                child: Text(
                  head,
                  style: _txtCustomHead,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new AddressListView(AppConstants.SETTINGS_SCREEN)));
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          sub1,
                          style: _txtCustomSub,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black38,
                        )
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new ProfileView()));
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          sub2,
                          style: _txtCustomSub,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black38,
                        )
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new ChangePasswordView()));
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          sub3,
                          style: _txtCustomSub,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black38,
                        )
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
