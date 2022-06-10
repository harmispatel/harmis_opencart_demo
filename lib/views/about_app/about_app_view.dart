import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/services/api_url.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/local_images.dart';

class AboutAppsView extends StatefulWidget {
  @override
  _AboutAppsViewState createState() => _AboutAppsViewState();
}

class _AboutAppsViewState extends State<AboutAppsView> {
  @override
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

  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: ApiUrl.ABOUT_US_STATIC,
      appBar: AppBar(
        title: Text(
          S.of(context).aboutApps,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15.0,
              color: Colors.white,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CommonColors.primaryColor,
        elevation: 0.0,
      ),
    );

    /*return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).aboutApps,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15.0,
              color: Colors.white,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CommonColors.primaryColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Divider(
                  height: 0.5,
                  color: Colors.black12,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      LocalImages.logo,
                      height: 50.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            S.of(context).title,
                            style: _txtCustomSub.copyWith(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Divider(
                  height: 0.5,
                  color: Colors.black12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the "
                  "industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and "
                  "scrambled it to make a type specimen book. \n\n\n It has survived not only five centuries, but also "
                  "the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the "
                  "1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with "
                  "desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  style: _txtCustomSub,
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ),
    );*/
  }
}
