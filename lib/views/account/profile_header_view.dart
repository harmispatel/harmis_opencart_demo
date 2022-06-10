import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/local_images.dart';
import 'package:harmis_opencart/views/account/account_view_model.dart';
import 'package:harmis_opencart/views/profile/profile_view.dart';
import 'package:provider/provider.dart';

/// Custom Font
var _txt = TextStyle(
  color: Colors.black,
  fontFamily: "Sans",
);

class ProfileHeaderView extends StatelessWidget {
  /// Get _txt and custom value of Variable for Name User
  var _txtName = _txt.copyWith(fontWeight: FontWeight.w700, fontSize: 17.0);

  var _txtEdit = _txt.copyWith(color: Colors.black26, fontSize: 15.0);

  @override
  Widget build(BuildContext context) {
    final mViewModel = Provider.of<AccountViewModel>(context);

    return Padding(
      padding: EdgeInsets.only(
        top: 185.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2.5),
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: !CommonUtils.isEmpty(
                              mViewModel.loginDetails?.profileImage)
                          ? new NetworkImage(mViewModel.loginDetails?.profileImage?? "")
                          : AssetImage(LocalImages.logo),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  mViewModel.loginDetails != null ? mViewModel.loginDetails.firstName +
                      " " +
                      mViewModel.loginDetails.lastName : '',
                  style: _txtName,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new ProfileView())).then((value){
                        mViewModel.getUserDetails();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Text(
                    S.of(context).editProfile,
                    style: _txtEdit,
                  ),
                ),
              ),
            ],
          ),
          Container(),
        ],
      ),
    );
  }
}
