import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/home/account/events/events_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prod_name/constants/Constants.dart' as Constants;


class ThirdAddScreen extends StatefulWidget {
  @override
  _ThirdAddScreenState createState() => _ThirdAddScreenState();
}

class _ThirdAddScreenState extends State<ThirdAddScreen> {
  SharedPreferences sharedPreferences;

  @override
  void initState(){
    super.initState();
    checkStorageStatus();
  }

  checkStorageStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  addEvent() async {
    Map<String, String> data = {
      "title":sharedPreferences.getString('eventName'),
      "startDate":sharedPreferences.getString('dateFrom'),
      "startTime":sharedPreferences.getString('timeFrom'),
      "endDate":sharedPreferences.getString('dateTo'),
      "endTime":sharedPreferences.getString('timeTo'),
      "description":descriptionText.text,
      "city":sharedPreferences.getString('eventCity'),
      "address":sharedPreferences.getString('eventAddress'),
      "entryType":sharedPreferences.getString('eventType'),
      "freePlacesCount": sharedPreferences.getInt('freePlaces').toString(),
      "organizer": sharedPreferences.getInt('id').toString()
    };


    var url = Constants.baseURL + "party";
    var response = await http.post(url, body:data);
    print(url);
    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => EventsScreen()),
            (Route<dynamic> route) => false);
      });
    }else{
      throw new Exception("Not send data");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppTranslations.of(context).text("events_add_event"),
          style: TextStyle(color: Colors.black, letterSpacing: 1),
        ),
        elevation: 0.0,
        centerTitle: true,
        bottom: PreferredSize(
          child: Container(color: Colors.black, height: 0.1),
          preferredSize: Size.fromHeight(0.1),
        ),
      ),
      body: SingleChildScrollView(
              child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      children: <Widget>[
                        textEditor(),
                        SizedBox(height: 30),
                        _infoText(),
                        SizedBox(height: 40),
                        _buttonSection(),

                      ],
                    ))
              ])),
    );
  }

  TextEditingController descriptionText = new TextEditingController();

  Widget textEditor(){
    return Container(
      height: 200,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                AppTranslations.of(context).text("events_add_description"),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              ),
            ],
          ),
          SizedBox(height: 15),
          TextField(
            maxLengthEnforced: true,
            maxLength: 250,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: descriptionText,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.black)
              )
            ),
          )
        ],
      ),
    );
  }


  Container _buttonSection() {
    return Container(
      child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 55.0,
      child: RaisedButton(
        onPressed: () async {
          addEvent();

          sharedPreferences.remove('dateTo');
          sharedPreferences.remove('timeFrom');
          sharedPreferences.remove('eventType');
          sharedPreferences.remove('freePlaces');
          sharedPreferences.remove('dateFrom');
          sharedPreferences.remove('timeTo');
          sharedPreferences.remove('eventName');
          sharedPreferences.remove('eventCity');
          sharedPreferences.remove('eventAddress');
        },
        child: Text(AppTranslations.of(context).text("events_add_event").toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        color: Colors.green,
      ),
    ));
  }

  Container _infoText() {
    return Container(
      child: GestureDetector(
        child: Text(
          AppTranslations.of(context).text("event_info_text"),
          style: TextStyle(fontSize: 14.0, color: Color.fromRGBO(136, 136, 136, 100)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
