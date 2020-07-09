import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prod_name/api/user_api_service.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/home/account/settings/settings_screen.dart';
import 'package:prod_name/ui/start/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountScreen extends StatefulWidget{
  @override
  DeleteAccountScreenState createState() => DeleteAccountScreenState();
}

class DeleteAccountScreenState extends State<DeleteAccountScreen>{
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
  Widget build(BuildContext context){
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(AppTranslations.of(context).text("settings_delete_the_account"), style: TextStyle(color: Colors.black, letterSpacing: 1)),
            elevation: 0.0,
            centerTitle: true,
            bottom: PreferredSize(child: Container(color: Colors.black, height: 0.1), preferredSize: Size.fromHeight(0.1),),
          ),
          body: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Icon(Icons.error, color: Colors.red, size: 130),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(AppTranslations.of(context).text("settings_delete_ask"), style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(AppTranslations.of(context).text("settings_delete_description"), style: TextStyle(fontSize: 14), textAlign: TextAlign.center,),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.0, left: 40, right: 40),
                child: Container(
                    child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 55.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                      onPressed: () async {
                          return showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                content: Text(AppTranslations.of(context).text("settings_delete_ask")),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      AppTranslations.of(context).text("log_out_confirm"),
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                    ),
                                    onPressed: () async {
                                      await userApiService.deleteAccount(sharedPreferences.getInt("id"));
                                      Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          StartScreen()));
                                    },
                                  ),
                                  FlatButton(
                                    child: Text(
                                      AppTranslations.of(context).text("log_out_cancel"),
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            }
                          );
                      },
                      child: Text(
                        AppTranslations.of(context).text("settings_delete_the_account").toUpperCase(),
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.red,
                    )))
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 40, right: 40),
                child: Container(
                    child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 55.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute( builder: (context) => SettingsScreen(payload: null,)));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                      child: Text(
                        AppTranslations.of(context).text("settings_delete_ask_cancel").toUpperCase(),
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.green,
                    )))
              )
            ],
          ),
      );  
  }
}