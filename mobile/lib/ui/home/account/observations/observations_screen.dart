import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prod_name/api/user_api_service.dart';
import 'package:prod_name/models/User.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/home/account/observations/follow_me.dart';
import 'package:prod_name/ui/home/account/observations/my_follows.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObservationsScreen extends StatefulWidget{
  @override
  _ObservationsScreenState createState() => _ObservationsScreenState();
}

class _ObservationsScreenState extends State<ObservationsScreen> with SingleTickerProviderStateMixin{

  SharedPreferences sharedPreferences;
  UserApiService userApiService;
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
  Widget build(BuildContext context){
    return SafeArea(
      child: FutureBuilder<SharedPreferences>(
        future:SharedPreferences.getInstance(),
        builder: (context, snapshot){
        if(!snapshot.hasData){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(AppTranslations.of(context).text("observations"), style: TextStyle(color: Colors.black, letterSpacing: 1),),
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
            title: Text(AppTranslations.of(context).text("observations"), style: TextStyle(color: Colors.black, letterSpacing: 1),),
            elevation: 0.0,
            centerTitle: true,
            bottom: PreferredSize(child: Container(color: Colors.black, height: 0.1), preferredSize: Size.fromHeight(0.1),),
            ),
            body: DefaultTabController(
              length: 2,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      appBar: new PreferredSize(
                        preferredSize: Size.fromHeight(kToolbarHeight),
                        child: new Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20, bottom: 20.0),
                            child: new TabBar(
                              indicatorSize: TabBarIndicatorSize.label,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Colors.black,
                              labelPadding: EdgeInsets.all(0),
                              indicatorPadding: EdgeInsets.all(0),
                              tabs: [
                                Tab(
                                  child: Container(
                                   
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(AppTranslations.of(context).text("observations_following"),  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 5),
                                          Text(sharedPreferences.getInt('countMyFollows').toString(), style: TextStyle(color: Colors.black))
                                        ],
                                      )
                                    ),
                                  )),
                                  Tab(
                                  child: Container(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text(AppTranslations.of(context).text("observations_followed_by"),  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 5),
                                              Text(sharedPreferences.getInt('countFollowedBy').toString(), style: TextStyle(color: Colors.black))
                                            ],
                                          )
                                        ),
                                  )),
                                ],
                            ),
                          )
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          MyFollows(),
                          FollowMe()
                        ],
                      ),
                    ))],)
            ),
          );
        }
      )
    );
  }
}