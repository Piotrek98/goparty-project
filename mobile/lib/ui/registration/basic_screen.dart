import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/registration/password_screen.dart';
import 'package:prod_name/ui/start/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicScreen extends StatefulWidget{
  @override
  _BasicScreenState createState() => _BasicScreenState();
}

class _BasicScreenState extends State<BasicScreen>{

  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  String _firstName;
  String _lastName;
  String _email;

  saveData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('firstNameForm', firstNameController.text);
    sharedPreferences.setString('lastNameForm', lastNameController.text);
    sharedPreferences.setString('emailForm', emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    return Scaffold(
      body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: _headerSection()
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 100.0),//TODO: do zmainy, dac grafike
                        _buildFirstName(),
                        SizedBox(height: 40.0),
                        _buildLastName(),
                        SizedBox(height: 40.0),
                        _buildEmail(),
                        SizedBox(height: 40.0),
                        _buttonSection(),
                        SizedBox(height: 40.0),
                        _helpText(),
                      ],
                    ))
              ]))),
    );
  }

  Container _headerSection() {
    return Container(
        child: Column(children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: IconButton(
              color: Color.fromRGBO(136, 136, 136, 1),
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StartScreen()));
              },
            ),
          )
        ],
      ),
    ]));
  }

  Widget _buildFirstName() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 0.8 * width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppTranslations.of(context).text("user_first_name").toUpperCase(),
            style: TextStyle(
                fontSize: 12.0, color: Color.fromRGBO(136, 136, 136, 1)),
          ),
          TextFormField(
            controller: firstNameController,
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
              _firstName = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLastName() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 0.8 * width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppTranslations.of(context).text("user_last_name").toUpperCase(),
            style: TextStyle(
                fontSize: 12.0, color: Color.fromRGBO(136, 136, 136, 1)),
          ),
          TextFormField(
            controller: lastNameController,
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
              _lastName = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmail() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 0.8 * width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppTranslations.of(context).text("user_email").toUpperCase(),
            style: TextStyle(
                fontSize: 12.0, color: Color.fromRGBO(136, 136, 136, 1)),
          ),
          TextFormField(
            controller: emailController,
            style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1)),
            decoration: InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide()),
              hintStyle: TextStyle(color: Colors.blue),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return AppTranslations.of(context).text("validate_empty_field");
              } 

              if(!value.contains('@')){
                return AppTranslations.of(context).text("register_incorrect_password");
              }
            },
            onSaved: (String value) {
              _email = value;
            },
          ),
        ],
      ),
    );
  }

  Container _buttonSection() {
    return Container(
        child: SizedBox(
      width: MediaQuery.of(context).size.width*0.4,
      height: 55.0,
      child: RaisedButton(
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            return;
          }
          saveData();
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => PasswordScreen()));
        },
        child: Text(AppTranslations.of(context).text("register_next").toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        color: Colors.red,
      ),
    ));
  }

  Container _helpText() {
    return Container(
      child: GestureDetector(
        child: Text(
          AppTranslations.of(context).text("register_help_ask"),
          style: TextStyle(
              fontSize: 12, color: Color.fromRGBO(136, 136, 136, 100)),
        ),
      ),
    );
  }
}