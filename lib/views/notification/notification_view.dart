import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/notificationsData.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/views/notification/no_notification.dart';
import 'package:harmis_opencart/views/notification/notification_view_model.dart';
import 'package:provider/provider.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final List<Post> items = new List();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<NotificationViewModel>(context).getNotification();
    });
  }

  Widget build(BuildContext context) {

    final mViewModel = Provider.of<NotificationViewModel>(context);

    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            S.of(context).notification,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: "Gotik"),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: CommonColors.primaryColor,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: mViewModel.notificationList.length > 0
            ? ListView.builder(
                itemCount: mViewModel.notificationList.length,
                padding: const EdgeInsets.all(5.0),
                itemBuilder: (context, position) {
                  return Dismissible(
                      key: Key(mViewModel.notificationList[position].statusId.toString()),
                      onDismissed: (direction) {
                        setState(() {
                          items.removeAt(position);
                        });
                      },
                      background: Container(
                        color: Color(0xFF6991C7),
                      ),
                      child: Container(
                        height: 88.0,
                        child: Column(
                          children: <Widget>[
                            Divider(height: 5.0),
                            ListTile(
                              title: Text(
                                '${mViewModel.notificationList[position].orderNo}',
                                style: TextStyle(
                                    fontSize: 17.5,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Container(
                                  width: 440.0,
                                  child: Text(
                                    '${mViewModel.notificationList[position].statusName}',
                                    style: new TextStyle(
                                        fontSize: 15.0,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black38),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              leading: Column(
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(60.0)),
                                        image: DecorationImage(
                                            image: AssetImage( "assets/img/Logo.png"),
                                            fit: BoxFit.cover)),
                                  )
                                ],
                              ),
                              onTap: () => _onTapItem(context, items[position]),
                            ),
                            Divider(height: 5.0),
                          ],
                        ),
                      ));
                })
            : NoItemNotificationsView());
  }
}

void _onTapItem(BuildContext context, Post post) {
  Scaffold.of(context).showSnackBar(
      new SnackBar(content: new Text(post.id.toString() + ' - ' + post.title)));
}
