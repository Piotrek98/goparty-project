import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prod_name/ui/home/account/account_screen.dart';

//TO DO THIS PAGE
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
        children: <Widget>[
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
                              MaterialPageRoute(builder: (context) => AccountScreen()));
                          },
                          // child: Text(AppTranslations.of(context).text("register").toUpperCase(),
                          child: Text("GO TO APP!",
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
