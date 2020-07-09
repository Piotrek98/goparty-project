import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/login/login_screen.dart';
import 'package:prod_name/ui/registration/basic_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatelessWidget {

  final String graphic = 'assets/graphic/dancing_group.svg';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
        children: <Widget>[
          // Positioned(
          //   top: 50.0,
          //   child: SvgPicture.asset(
          //     graphic,
          //     height: 350,
          //   )
          // ),
          Positioned(
              bottom: 50.0,
                child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60.0,
                        width: width*0.8,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child: Text(AppTranslations.of(context).text("login").toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          color: Colors.orange,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(AppTranslations.of(context).text("login_or"),
                                  style: TextStyle(
                                      color: Color.fromRGBO(136, 136, 136, 100),
                                      fontSize: 12.0))
                            ],
                          )),
                      SizedBox(
                        height: 60.0,
                        width: width*0.8,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BasicScreen()));
                          },
                          child: Text(AppTranslations.of(context).text("register").toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          color: Colors.red,
                        ),
                      )
                    ]),
              )
        ],
      )),
    );
  }
}
