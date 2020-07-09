import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prod_name/api/user_api_service.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/home/account/events/create/first_add_screen.dart';
import 'package:prod_name/ui/home/account/events/my_events.dart';
import 'package:prod_name/ui/home/account/events/interested.dart';
import 'package:prod_name/ui/home/account/events/take_part.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsScreen extends StatefulWidget{
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> with SingleTickerProviderStateMixin{

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
              title: Text(AppTranslations.of(context).text("events"), style: TextStyle(color: Colors.black, letterSpacing: 1),),
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
            title: Text(AppTranslations.of(context).text("events"), style: TextStyle(color: Colors.black, letterSpacing: 1),),
            elevation: 0.0,
            centerTitle: true,
            bottom: PreferredSize(child: Container(color: Colors.black, height: 0.1), preferredSize: Size.fromHeight(0.1),),
            ),
            body: DefaultTabController(
              length: 3,
              child: Stack(
                children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 80.0, right: 80, top: 20),
                          child: FlatButton(
                          color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(AppTranslations.of(context).text("events_add_event"), style: TextStyle(color: Colors.white)),
                                SizedBox(width: 10),
                                Icon(Icons.edit, color: Colors.white,)
                              ],
                            ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => FirstAddScreen()));
                          },
                        ),
                      ),
                  Padding(
                    padding: EdgeInsets.only(top: 80.0),
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      appBar: new PreferredSize(
                        preferredSize: Size.fromHeight(kToolbarHeight),
                        child: new Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 0, bottom: 20.0),
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
                                          Text(AppTranslations.of(context).text("events_interested"),  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 2),
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
                                                Text(AppTranslations.of(context).text("events_you_will_take_part"),  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                                SizedBox(width: 2),
                                              ],
                                            )
                                          ),
                                    )
                                  ),
                                  Tab(
                                    child: Container(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(AppTranslations.of(context).text("events_organized"),  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                                SizedBox(width: 2),
                                              ],
                                            )
                                          ),
                                    )
                                  ),
                                ],
                            ),
                          )
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          InteredstedScreen(),
                          TakePart(),
                          MyEvents()
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