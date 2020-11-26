import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prod_name/api/user_api_service.dart';
import 'package:prod_name/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FollowMe extends StatefulWidget{
  @override
  _FollowMeState createState() => _FollowMeState();
}

class _FollowMeState extends State<FollowMe> {

  UserApiService userApiService;
  SharedPreferences sharedPreferences;
  Future _future;

  @override
  void initState(){
    super.initState();
    userApiService = UserApiService();
    _future = getUserData();
  }

  getUserData() async{
    sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt('id');
    return userApiService.getUser(id);
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              // child: CircularProgressIndicator(),
              child: Text(
                "Empty :("
              )
            ),
          );
        }
        User user = snapshot.data;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: ListView.builder(
              itemCount: user.followedBy.length,
              itemBuilder: (context, i){
                return GestureDetector(
                  onTap: () {
                    //
                  },
                  child: Card(
                    margin: EdgeInsets.only(top: 15, right: 10, left: 10),
                    child: ListTile(
                      title: Text(user.followedBy[i].firstName + ' ' + user.followedBy[i].lastName),
                      subtitle: Text(user.followedBy[i].accountName),
                      leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/8/8d/George_Clooney_2016.jpg'),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          _handleClickMe();
                        },
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
          title: Text('Wybierz działanie', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text('Pokaż profil', style: TextStyle(color: Colors.black)),
              onPressed: () { /** */ },
            ),
            CupertinoActionSheetAction(
              child: Text('Zablokuj', style: TextStyle(color: Colors.black)),
              onPressed: () { /** */ },
            ),
            CupertinoActionSheetAction(
              child: Text('Zgłoś', style: TextStyle(color: Colors.black)),
              onPressed: () { /** */ },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text('Anuluj', style: TextStyle(color: Colors.black)),
            onPressed: () { 
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}