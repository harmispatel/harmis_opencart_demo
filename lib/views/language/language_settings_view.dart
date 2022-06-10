import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/local_images.dart';
import 'package:harmis_opencart/views/language/language_view.dart';


class LanguageSettingView extends StatefulWidget {
  LanguageSettingView({Key key}) : super(key: key);

  _LanguageSettingViewState createState() => _LanguageSettingViewState();
}

class _LanguageSettingViewState extends State<LanguageSettingView> {
  @override
  Widget build(BuildContext context) {

   // var data = EasyLocalizationProvider.of(context).data;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            S.of(context).languageSetting,
            style: TextStyle(
                fontFamily: "Gotik",
                fontWeight: FontWeight.w600,
                fontSize: 18.5,
                letterSpacing: 1.2,
                color: Colors.white

            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: CommonColors.primaryColor,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              InkWell(
                  onTap: (){
                    showDialog(
                        context: context,builder: (_) => NetworkGiffyDialog(
                      image: Image.asset("assets/img/earth.gif",fit: BoxFit.cover,),
                      title: Text(S.of(context).titleCard,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Gotik",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600)),
                      description:Text(S.of(context).descCard,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w300,
                            color: Colors.black26
                        ),
                      ),
                      onOkButtonPressed: () {
                        //data.changeLocale(Locale('en','US'));
                        Navigator.pop(context);

                      },

                    ) );
                  },
                  child: LanguageView(flag: LocalImages.us,title: S.of(context).english,)),
              InkWell(
                  onTap: (){
                    showDialog(
                        context: context,builder: (_) => NetworkGiffyDialog(
                      image: Image.asset(LocalImages.earth,fit: BoxFit.cover,),
                      title: Text(S.of(context).titleCard,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Gotik",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600)),
                      description:Text(S.of(context).descCard,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w300,
                            color: Colors.black26
                        ),
                      ),
                      onOkButtonPressed: () {
                        //data.changeLocale(Locale('ar','DZ'));
                        Navigator.pop(context);

                      },

                    ) );
                  },
                  child: LanguageView(flag: LocalImages.arab,title: S.of(context).arabic,)),InkWell(
                  onTap: (){
                    showDialog(
                        context: context,builder: (_) => NetworkGiffyDialog(
                      image: Image.asset(LocalImages.earth,fit: BoxFit.cover,),
                      title: Text(S.of(context).titleCard,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Gotik",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600)),
                      description:Text(S.of(context).descCard,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w300,
                            color: Colors.black26
                        ),
                      ),
                      onOkButtonPressed: () {
                        //data.changeLocale(Locale('zh','HK'));
                        Navigator.pop(context);

                      },

                    ) );
                  },
                  child: LanguageView(flag: LocalImages.china,title: S.of(context).chinese,)),InkWell(
                  onTap: (){
                    showDialog(
                        context: context,builder: (_) => NetworkGiffyDialog(
                      image: Image.asset(LocalImages.earth,fit: BoxFit.cover,),
                      title: Text(S.of(context).titleCard,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Gotik",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600)),
                      description:Text(S.of(context).descCard,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w300,
                            color: Colors.black26
                        ),
                      ),
                      onOkButtonPressed: () {
                        //data.changeLocale(Locale('hi','IN'));
                        Navigator.pop(context);

                      },

                    ) );
                  },
                  child: LanguageView(flag: LocalImages.india,title: S.of(context).hindi,)),InkWell(
                  onTap: (){
                    showDialog(
                        context: context,builder: (_) => NetworkGiffyDialog(
                      image: Image.asset(LocalImages.earth,fit: BoxFit.cover,),
                      title: Text(S.of(context).titleCard,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Gotik",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600)),
                      description:Text(S.of(context).descCard,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w300,
                            color: Colors.black26
                        ),
                      ),
                      onOkButtonPressed: () {
                        //data.changeLocale(Locale('id','ID'));
                        Navigator.pop(context);
                      },
                    ) );
                  },
                  child: LanguageView(flag: LocalImages.indonesia,title: S.of(context).indonesia,)),
              SizedBox(height: 70.0,)
            ],
          ),
        ),
      );
  }
}

