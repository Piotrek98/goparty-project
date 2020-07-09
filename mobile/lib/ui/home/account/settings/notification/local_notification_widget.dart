import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/service/notifications/local_notications_helper.dart';
import 'package:prod_name/ui/home/account/settings/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prod_name/ui/home/account/settings/notification/notification_screen_description.dart';

class LocalNotificationWidget extends StatefulWidget {
  @override
  _LocalNotificationWidgetState createState() =>
      _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  final notifications = FlutterLocalNotificationsPlugin();
  bool switchState = false;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getSwitchStatus();

    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen(payload: payload)),
      );

    Future<bool> getSwitchStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool status = sharedPreferences.getBool("switchNotificationStatus");
    return status;
  }

  void setSwitchStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("switchNotificationStatus", switchState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(AppTranslations.of(context).text("settings_notifications"), style: TextStyle(color: Colors.black, letterSpacing: 1)),
            elevation: 0.0,
            centerTitle: true,
            bottom: PreferredSize(child: Container(color: Colors.black, height: 0.1), preferredSize: Size.fromHeight(0.1),),
          ),
          body: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: SizedBox(
                      height: 150,
                      width: 800,
                    child: Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text(AppTranslations.of(context).text("settings_notifications_access")),
                            subtitle: Text(AppTranslations.of(context).text("settings_notifications_access_description")),
                          ),
                          Row(
                            children: <Widget>[
                              FutureBuilder(
                                //TODO: The method 'getBool' was called on null.
                                future: SharedPreferences.getInstance(),
                                builder: (context, snapshot){
                                  return Switch(
                                    value: sharedPreferences.getBool("switchNotificationStatus") ?? false,
                                    // value: false,
                                    onChanged: (bool s) {
                                      switchState = s;
                                      sharedPreferences.setBool("switchNotificationStatus", switchState);
                                      setState(() {
                                        if(switchState){
                                        showOngoingNotification(notifications,
                                          title: AppTranslations.of(context).text("settings_notification"),
                                          body: AppTranslations.of(context).text("settings_notifications_body"));
                                        }
                                      });
                                    },
                                  );
                                }
                              ),
                            ],
                          )
                        ],
                      ),
                      )
                    )
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: SizedBox(
                      height: 80,
                      width: 800,
                    child: GestureDetector(
                      child: Card(
                        elevation: 8.0,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(AppTranslations.of(context).text("find_out_more"), style: TextStyle(fontSize: 16))
                            ],
                          )
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute( builder: (context) => NotificationScreenDescription()));
                      },
                    )
                  ),
                  )
                ],
              )
          )
    );
  }
}