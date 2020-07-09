import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prod_name/api/user_api_service.dart';
import 'package:prod_name/models/User.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/home/account/settings/notification/local_notification_widget.dart';
import 'package:prod_name/ui/home/account/settings/language/language_selector.dart';
import 'package:prod_name/ui/home/account/settings/location/location_screen.dart';
import 'package:prod_name/ui/home/account/settings/personal_info/personal_info_sceen.dart';
import 'package:prod_name/ui/home/account/settings/deactivate_account/delete_account_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget{
  final String payload;

  const SettingsScreen({
    @required this.payload,
    Key key,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{

  UserApiService userApiService;
  BuildContext context;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    this.context = context;
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(AppTranslations.of(context).text("settings_name"), style: TextStyle(color: Colors.black, letterSpacing: 1),),
            elevation: 0.0,
            centerTitle: true,
            bottom: PreferredSize(child: Container(color: Colors.black, height: 0.1), preferredSize: Size.fromHeight(0.1),),
          ),
          body: SingleChildScrollView(
            child: Column(
            children: <Widget>[
              Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: Row(children: <Widget>[
                            Text(
                              AppTranslations.of(context).text("account"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(136, 136, 136, 10)),
                            )
                          ])),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text(
                            AppTranslations.of(context).text("settings_personal_info"),
                            style: TextStyle(
                              fontSize: 16.0,
                              letterSpacing: 1.0,
                              color: Colors.black,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute( builder: (context) => PersonalInfoScreen()));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.notifications,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text(
                            AppTranslations.of(context).text("settings_notifications"),
                            style: TextStyle(
                              fontSize: 16.0,
                              letterSpacing: 1.0,
                              color: Colors.black,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute( builder: (context) => LocalNotificationWidget()));
                          },
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.language,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Text(
                              AppTranslations.of(context).text("settings_language"),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute( builder: (context) => LanguageSelector()));
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Text(
                              AppTranslations.of(context).text("settings_location"),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute( builder: (context) => LocationScreen()));
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.power_settings_new,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Text(
                              AppTranslations.of(context).text("settings_delete_the_account"),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute( builder: (context) => DeleteAccountScreen()));
                            },
                          )),
            ])
          ),
        );
  }
}



