import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prod_name/api/user_api_service.dart';
import 'package:prod_name/models/User.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyEvents extends StatefulWidget {
  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  UserApiService userApiService;
  SharedPreferences sharedPreferences;
  Future _future;

  @override
  void initState() {
    super.initState();
    userApiService = UserApiService();
    _future = getUserData();
  }

  getUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt('id');
    return userApiService.getUser(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              // child: CircularProgressIndicator(),
              child: Text(
                "Empty :("
              ),
            ),
          );
        }
        User user = snapshot.data;
        return user.myEvents.isEmpty 
        ? Center(
          child: Text(AppTranslations.of(context).text("event_no_organize"), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade300))) 
        : Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              child: ListView.builder(
                  itemCount: user.myEvents.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        onTap: () {
                          //
                        },
                        child: Container(
                          height: 160.0,
                          margin: EdgeInsets.all(5),
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6),
                                  BlendMode.dstATop),
                                  image: new NetworkImage('https://vignette.wikia.nocookie.net/robcraftbloxboys/images/c/c1/Elemental_Plane_of_Party.jpg/revision/latest?cb=20180605200744')
                                  )
                                ),
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: <Widget>[
                                    Positioned(
                                      top: 3,
                                      right: 3,
                                      child: IconButton(
                                        icon: Icon(Icons.info),
                                        color: Colors.white,
                                        onPressed: () {
                                          //
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              user.myEvents[i].title,
                                              style: TextStyle(
                                                fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              user.myEvents[i].startDate + AppTranslations.of(context).text("event_at_hour") + user.myEvents[i].startTime, 
                                              style: TextStyle(fontSize: 12, color: Colors.redAccent, fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        ]
                                      )
                                    )
                                  ],
                                ),
                            ),
                          ),
                        )
                      );
                  })),
        );
      },
    );
  }
}
