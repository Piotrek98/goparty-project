import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/home/account/settings/location/location_screen_description.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationScreen extends StatefulWidget{
  @override
  LocationScreenState createState() => LocationScreenState(); 
}

class LocationScreenState extends State<LocationScreen> {

  bool switchState = false;
  final PermissionHandler _permissionHandler = PermissionHandler();
  SharedPreferences sharedPreferences;

  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestLocationPermission() async {
    return _requestPermission(PermissionGroup.locationWhenInUse);
  }

  @override
  void initState(){
    super.initState();
    getSwitchStatus();
  }

  Future<bool> getSwitchStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool status = sharedPreferences.getBool("switchStatus");
    return status;
  }

  void setSwitchStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("switchStatus", switchState);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(AppTranslations.of(context).text("settings_location"), style: TextStyle(color: Colors.black, letterSpacing: 1)),
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
                            title: Text(AppTranslations.of(context).text("settings_location_access")),
                            subtitle: Text(AppTranslations.of(context).text("settings_location_access_description")),
                          ),
                          Row(
                            children: <Widget>[
                              FutureBuilder(
                                //TODO: The method 'getBool' was called on null.
                                future: SharedPreferences.getInstance(),
                                builder: (context, snapshot){
                                  return Switch(
                                    value: sharedPreferences.getBool("switchStatus") ?? false,
                                    // value: true,
                                    onChanged: (bool s) {
                                      switchState = s;
                                      sharedPreferences.setBool("switchStatus", switchState);
                                      setState((){
                                        if(switchState){
                                          requestLocationPermission();
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
                        Navigator.push(context, MaterialPageRoute( builder: (context) => LocationScreenDescription()));
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