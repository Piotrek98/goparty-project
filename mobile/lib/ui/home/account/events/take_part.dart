import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prod_name/api/party_api_service.dart';
import 'package:prod_name/api/user_api_service.dart';
import 'package:prod_name/models/User.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TakePart extends StatefulWidget{
  @override
  _TakePartState createState() => _TakePartState();
}

class _TakePartState extends State<TakePart> {

  UserApiService userApiService;
  SharedPreferences sharedPreferences;
  PartyApiService partyApiService;
  Future _future;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    userApiService = UserApiService();
    partyApiService = PartyApiService();
    getUserData();
  }

  getUserData() async{
    sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt('id');
    return userApiService.getUser(id);
  }

  removeFromInterested(int pid) async {
    sharedPreferences = await SharedPreferences.getInstance();
    int uid = sharedPreferences.getInt('id');
    return partyApiService.removeUserFromEvent(uid, pid);
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
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
        return user.getInvolvedEvents.isEmpty 
        ? Center(
          child: Text(
            AppTranslations.of(context).text("event_no_take_part"),
            style: TextStyle(color: Colors.grey.shade300, fontSize: 16, fontWeight: FontWeight.bold))) 
        : Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: Container(
            child: ListView.builder(
              itemCount: user.getInvolvedEvents.length,
              itemBuilder: (context, i){
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
                                      bottom: 15,
                                      right: 5,
                                      child: Row(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.cancel, color: Colors.red, size: 35),
                                            onPressed: () {
                                              return showDialog(
                                                context: context,
                                                builder: (BuildContext context){
                                                  return AlertDialog(
                                                    content: Text(AppTranslations.of(context).text("event_cancel_ask") + '"${user.getInvolvedEvents[i].title}"?'),
                                                    actions: <Widget>[
                                                    FlatButton(
                                                      child: Text(
                                                        AppTranslations.of(context).text("event_yes"),
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black),
                                                      ),
                                                      onPressed: () async {
                                                        bool status = await removeFromInterested(user.getInvolvedEvents[i].id);
                                                        if(status){
                                                          Navigator.of(context).pop(null);
                                                          _scaffoldKey.currentState.showSnackBar(
                                                            SnackBar(
                                                              duration: const Duration(seconds: 3),
                                                              content: Text(AppTranslations.of(context).text("event_no_participate_info") + "${user.getInvolvedEvents[i].title}"),
                                                          ));
                                                        }
                                                      },
                                                    ),
                                                    FlatButton(
                                                        child: Text(
                                                          AppTranslations.of(context).text("event_no"),
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
                                                }
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.check_circle, color: Colors.green, size: 75),
                                            onPressed: () {
                                              //
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
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
                                              user.getInvolvedEvents[i].startDate + AppTranslations.of(context).text("event_at_hour") + user.getInvolvedEvents[i].startTime,
                                              style: TextStyle(fontSize: 12, color: Colors.redAccent, fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              user.getInvolvedEvents[i].title,
                                              style: TextStyle(
                                                fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              user.getInvolvedEvents[i].address + ', ' + user.getInvolvedEvents[i].city, 
                                              style: TextStyle(fontSize: 16, color: Colors.redAccent, fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                        ]
                                      )
                                    )
                                  ],
                                ),
                            ),
                          ),
                        )
                      );
              }
            )
          ),
        );
      },
    );
  }
}