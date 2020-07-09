import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/home/account/events/create/second_add_screen.dart';
import 'package:prod_name/ui/registration/password_screen.dart';
import 'package:prod_name/ui/start/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstAddScreen extends StatefulWidget {
  @override
  _FirstAddScreenState createState() => _FirstAddScreenState();
}

class _FirstAddScreenState extends State<FirstAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController eventNameController = new TextEditingController();
  final TextEditingController eventCityController = new TextEditingController();
  final TextEditingController eventAddressController =
      new TextEditingController();
  String _name;
  String _city;
  String _address;

  saveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('eventName', eventNameController.text);
    sharedPreferences.setString('eventCity', eventCityController.text);
    sharedPreferences.setString('eventAddress', eventAddressController.text);
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
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 50.0), //TODO: do zmainy, dac grafike
                        _buildEventName(),
                        SizedBox(height: 50.0),
                        _buildCityName(),
                        SizedBox(height: 50.0),
                        _buildAddressName(),
                        SizedBox(height: 80.0),
                        _buttonSection(),
                      ],
                    ))
              ]))),
    );
  }

  Widget _buildEventName() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 0.8 * width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppTranslations.of(context).text("events_name"),
            style: TextStyle(
                fontSize: 12.0, color: Color.fromRGBO(136, 136, 136, 1)),
          ),
          TextFormField(
            maxLength: 25,
            maxLengthEnforced: true,
            controller: eventNameController,
            style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1)),
            decoration: InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide()),
              hintStyle: TextStyle(color: Colors.blue),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return AppTranslations.of(context).text("validate_empty_field");
              } else
                return null;
            },
            onSaved: (String value) {
              _name = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCityName() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 0.8 * width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppTranslations.of(context).text("event_city"),
            style: TextStyle(
                fontSize: 12.0, color: Color.fromRGBO(136, 136, 136, 1)),
          ),
          TextFormField(
            controller: eventCityController,
            style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1)),
            decoration: InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide()),
              hintStyle: TextStyle(color: Colors.blue),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return AppTranslations.of(context).text("validate_empty_field");
              } else
                return null;
            },
            onSaved: (String value) {
              _city = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressName() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 0.8 * width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppTranslations.of(context).text("event_address"),
            style: TextStyle(
                fontSize: 12.0, color: Color.fromRGBO(136, 136, 136, 1)),
          ),
          TextFormField(
            controller: eventAddressController,
            style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1)),
            decoration: InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide()),
              hintStyle: TextStyle(color: Colors.blue),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return AppTranslations.of(context).text("validate_empty_field");
              }
            },
            onSaved: (String value) {
              _address = value;
            },
          ),
        ],
      ),
    );
  }

  Container _buttonSection() {
    return Container(
        child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 55.0,
      child: RaisedButton(
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            return;
          }
          saveData();
           Navigator.push(context,
                MaterialPageRoute(builder: (context) => SecondAddScreen()));
        },
        child: Text(AppTranslations.of(context).text("event_next_page"),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        color: Colors.green,
      ),
    ));
  }
}
