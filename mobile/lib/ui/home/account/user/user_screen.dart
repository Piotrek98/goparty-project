import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prod_name/api/user_api_service.dart';
import 'package:prod_name/models/User.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget{
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>{

  UserApiService userApiService;
  BuildContext context;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getUserData();
    userApiService = UserApiService();
  }

  getUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context){
    this.context = context;
    return SafeArea(
      child: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot){
        if(!snapshot.hasData){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(AppTranslations.of(context).text("account_screen_profile"), style: TextStyle(color: Colors.black, letterSpacing: 1),),
              elevation: 0.0,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    //
                  },
                )
              ],
              bottom: PreferredSize(child: Container(color: Colors.black, height: 0.1), preferredSize: Size.fromHeight(0.1),),
          ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(AppTranslations.of(context).text("account_screen_profile"), style: TextStyle(color: Colors.black, letterSpacing: 1),),
            elevation: 0.0,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  //
                },
              )
            ],
            bottom: PreferredSize(child: Container(color: Colors.black, height: 0.1), preferredSize: Size.fromHeight(0.1),),
          ),
          body: SingleChildScrollView(
            child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: _userInfoImage()
              ),
              new Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        sharedPreferences.getString('firstName') + ' ' + sharedPreferences.getString('lastName'),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text(
                        '#' + sharedPreferences.getString('accountName'),
                        style: TextStyle(
                          color: Color.fromRGBO(136, 136, 136, 90)
                        )
                      ),
                    )
                  ],
                )
              ),
              SizedBox(height: 20),
              Divider(),
              Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            AppTranslations.of(context).text("account_screen_followers"),
                            style: TextStyle(fontSize: 14),),
                          SizedBox(height: 3,),
                          Text(sharedPreferences.getInt('countMyFollows').toString(),style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      verticalDivider(),
                      Column(
                        children: <Widget>[
                          Text(
                            AppTranslations.of(context).text("account_screen_followed_by"),
                            style: TextStyle(fontSize: 14),),
                          SizedBox(height: 3,),
                          Text(sharedPreferences.getInt('countFollowedBy').toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                        ],
                      )
                    ],
                  ),
                )
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      FlatButton(
                        color: Colors.blue,
                        child: Row(
                          children: <Widget>[
                            Text(AppTranslations.of(context).text("account_screen_edit_profile"), style: TextStyle(color: Colors.white)),
                            SizedBox(width: 10),
                            Icon(Icons.edit, color: Colors.white,)
                          ],
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                        ),
                        onPressed: () {
                          //
                        },
                      ),
                  ]),
              ),
              SizedBox(height: 15,),
            ],)
          ),
        );
        })
    );
  }

  Container _userInfoImage() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0.0),
              child: Material(
                  elevation: 4.0,
                  shape: CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: Ink.image(
                    image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/8/8d/George_Clooney_2016.jpg'),
                    fit: BoxFit.cover,
                    width: 160.0,
                    height: 160.0,
                    child: InkWell(
                      onTap: () {

                      },
                    ),
                  ),
                )
          )
        ],
      )
    );
  }

  Widget verticalDivider() {
    return new Container(
      height: 40.0,
      width: 1.0,
      color: Colors.black,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
    );
  }
}



