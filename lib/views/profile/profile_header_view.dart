import 'dart:io';

import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/local_images.dart';
import 'package:harmis_opencart/views/account/account_view_model.dart';
import 'package:harmis_opencart/views/profile/profile_view.dart';
import 'package:harmis_opencart/views/profile/profile_view_model.dart';
import 'package:provider/provider.dart';

/// Custom Font
var _txt = TextStyle(
  color: Colors.black,
  fontFamily: "Sans",
);

class ProfileImageView extends StatelessWidget {
  /// Get _txt and custom value of Variable for Name User

  @override
  Widget build(BuildContext context) {

    final mViewModel = Provider.of<ProfileViewModel>(context);

    void _selectImageOption(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.camera),
                      title: new Text(S.of(context).camera),
                      onTap: () {
                        mViewModel.getImage(true);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.attach_file),
                    title: new Text(S.of(context).gallery),
                    onTap: () {
                      mViewModel.getImage(false);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          });
    }

    return mViewModel.loginDetails != null && mViewModel.loginDetails.profileImage != null ? Padding(
      padding: EdgeInsets.only(
        top: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 130,
            width: 120,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.5),
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: mViewModel.loginDetails.profileImage.startsWith("http") ? new NetworkImage(
                            mViewModel.loginDetails.profileImage) : FileImage(new File(mViewModel.loginDetails.profileImage)),
                      )),
                ),
                new Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: InkWell(
                      onTap: () {
                        _selectImageOption(context);
                      },
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(22.5)),
                          color: CommonColors.primaryColor,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.camera_enhance,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ) : Container();
  }
}
