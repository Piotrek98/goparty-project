import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prod_name/api/user_api_service.dart';
import 'package:prod_name/api/party_api_service.dart';
import 'package:prod_name/models/User.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:shared_preferences/shared_preferences.dart';


class InteredstedScreen extends StatefulWidget{
  @override
  _InteredstedScreenState createState() => _InteredstedScreenState();
}

class _InteredstedScreenState extends State<InteredstedScreen> {

  UserApiService userApiService;
  PartyApiService partyApiService;
  SharedPreferences sharedPreferences;

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

  addToParty(int pid) async {
    sharedPreferences = await SharedPreferences.getInstance();
    int uid = sharedPreferences.getInt('id');
    return partyApiService.addUserToEvent(uid, pid);
  }

  removeFromInterested(int pid) async {
    sharedPreferences = await SharedPreferences.getInstance();
    int uid = sharedPreferences.getInt('id');
    return partyApiService.removeUserFromEventInterested(uid, pid);
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
        return user.myInterestedEvents.isEmpty 
        ? Center(
          child: Text(
            AppTranslations.of(context).text("event_no_interested"), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade300))) 
        : Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: ListView.builder(
              itemCount: user.myInterestedEvents.length,
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
                                      right: 15,
                                      child: Row(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.check_circle, color: Colors.green, size: 45),
                                            onPressed: () async {
                                              bool status = await addToParty(user.myInterestedEvents[i].id);
                                              if(status){
                                                final snackBar = SnackBar(
                                                  duration: const Duration(seconds: 3),
                                                  content: Text(AppTranslations.of(context).text("event_take_part_in") + '${user.myInterestedEvents[i].title}!'),
                                                );

                                                Scaffold.of(context).showSnackBar(snackBar);
                                              }
                                            },
                                          ),
                                          SizedBox(width: 15),
                                          IconButton(
                                            icon: Icon(Icons.cancel, color: Colors.red, size: 45),
                                            onPressed: () async {
                                              bool status = await removeFromInterested(user.myInterestedEvents[i].id);
                                              if(status){
                                                final snackBar = SnackBar(
                                                  duration: const Duration(seconds: 3),
                                                  content: Text(AppTranslations.of(context).text("event_delete") + "${user.myInterestedEvents[i].title}" + AppTranslations.of(context).text("event_delete_next")),
                                                );

                                                Scaffold.of(context).showSnackBar(snackBar);
                                              }
                                            },
                                          )
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
                                              user.myInterestedEvents[i].startDate + AppTranslations.of(context).text("event_at_hour") + user.myInterestedEvents[i].startTime, 
                                              style: TextStyle(fontSize: 12, color: Colors.redAccent, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              user.myInterestedEvents[i].title,
                                              style: TextStyle(
                                                fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              user.myInterestedEvents[i].address + ', ' + user.myInterestedEvents[i].city, 
                                              style: TextStyle(fontSize: 16, color: Colors.redAccent, fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                        ], 
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


  Future<void> _handleClickMe() async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(AppTranslations.of(context).text("handle_click_title")),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(AppTranslations.of(context).text("handle_click_see_profile"), style: TextStyle(color: Colors.black)),
              onPressed: () { 
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ObservationUserScreen()));
               },
            ),
            CupertinoActionSheetAction(
              child: Text(AppTranslations.of(context).text("handle_click_see_profile"), style: TextStyle(color: Colors.black)),
              onPressed: () { /** */ },
            ),
            CupertinoActionSheetAction(
              child: Text(AppTranslations.of(context).text("handle_click_report"), style: TextStyle(color: Colors.black)),
              onPressed: () { /** */ },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text(AppTranslations.of(context).text("handle_click_cancel"), style: TextStyle(color: Colors.black)),
            onPressed: () { 
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}