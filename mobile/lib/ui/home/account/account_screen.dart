import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prod_name/api/user_api_service.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/home/account/events/events_screen.dart';
import 'package:prod_name/ui/home/account/observations/observations_screen.dart';
import 'package:prod_name/ui/home/account/user/user_screen.dart';
import 'package:prod_name/ui/home/account/settings/settings_screen.dart';
import 'package:prod_name/ui/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prod_name/constants/Constants.dart' as Constants;

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  SharedPreferences sharedPreferences;
  UserApiService userApiService;

  @override
  void initState() {
    super.initState();
    checkStorageStatus();
    userApiService = UserApiService();
  }

  checkStorageStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: RefreshProgressIndicator()),
            );
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(right: 30.0, top: 40.0),
              child: Padding(
                  padding: EdgeInsets.only(top: 0, left: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(),
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5.0),
                                  child: Material(
                                    elevation: 4.0,
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.hardEdge,
                                    color: Colors.transparent,
                                    child: Ink.image(
                                      image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/8/8d/George_Clooney_2016.jpg'),
                                      fit: BoxFit.cover,
                                      width: 60.0,
                                      height: 60.0,
                                      child: InkWell(
                                        onTap: () {

                                        },
                                      ),
                                    ),
                                  )
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  sharedPreferences.getString('firstName') +
                                      ' ' +
                                      sharedPreferences.getString('lastName'),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(AppTranslations.of(context).text("account_screen_see_my_profile"), style: TextStyle(fontSize: 12),)
                              ],
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserScreen()));
                        },
                      ),
                      Divider(),
                      SizedBox(height: 30.0),
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
                            AppTranslations.of(context).text("account_screen_profile"),
                            style: TextStyle(
                              fontSize: 16.0,
                              letterSpacing: 1.0,
                              color: Colors.black,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserScreen()));
                          },
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.people,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Text(
                              AppTranslations.of(context).text("observations"),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute( builder: (context) => ObservationsScreen()));
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.event,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Text(
                              AppTranslations.of(context).text("events"),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute( builder: (context) => EventsScreen()));
                            },
                          )),
                      Divider(),
                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: Row(children: <Widget>[
                            Text(
                              AppTranslations.of(context).text("support"),
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
                              Icons.settings,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Text(
                              AppTranslations.of(context).text("settings_name"),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute( builder: (context) => SettingsScreen(payload: null,)));
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Text(
                              AppTranslations.of(context).text("report_a_problem"),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.help,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Text(
                              AppTranslations.of(context).text("help"),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                      Divider(),
                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: Row(children: <Widget>[
                            Text(
                              AppTranslations.of(context).text("about_app"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(136, 136, 136, 10)),
                            )
                          ])),
                      SizedBox(height: 10),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.book,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Text(
                              AppTranslations.of(context).text("regulations"),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.file_upload,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Text(
                              AppTranslations.of(context).text("privacy_policy"),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  letterSpacing: 1.0),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                      Divider(),
                      Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.power_settings_new,
                              color: Colors.red,
                              size: 30,
                            ),
                            title: Text(
                              AppTranslations.of(context).text("log_out"),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.red,
                                  letterSpacing: 1.0),
                            ),
                            onTap: () async {
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                            AppTranslations.of(context).text("log_out_ask")),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              AppTranslations.of(context).text("log_out_confirm"),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            onPressed: () async {
                                              await userApiService.logoutUser();
                                              sharedPreferences.remove("id");
                                              sharedPreferences.remove("firstName");
                                              sharedPreferences.remove("lastName");
                                              sharedPreferences.remove("accountName");
                                              sharedPreferences.remove("countFollowedBy");
                                              sharedPreferences.remove("countMyFollows");
                                              sharedPreferences.remove("profileImage");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginScreen()));
                                            },
                                          ),
                                          FlatButton(
                                            child: Text(
                                              AppTranslations.of(context).text("log_out_cancel"),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(null);
                                            },
                                          )
                                        ],
                                      );
                                    });
                            },
                          )),
                      SizedBox(height: 50.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            Constants.VERSION_NUMBER,
                            style: TextStyle(fontSize: 12.0),
                          )
                        ],
                      )
                    ],
                  )),
            )),
          );
        });
  }
}
