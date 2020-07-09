import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';

class NotificationScreenDescription extends StatelessWidget{

  @override
  Widget build(BuildContext context){
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
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Text(AppTranslations.of(context).text("settings_notifications_more_info"), style: TextStyle(fontSize: 16),)
                ],
              ),
            )
          )
    );
  }
}