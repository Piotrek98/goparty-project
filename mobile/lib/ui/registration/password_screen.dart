import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prod_name/api/user_api_service.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/registration/basic_screen.dart';
import 'package:http/http.dart' as http;
import 'package:prod_name/ui/registration/verification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prod_name/constants/Constants.dart' as Constant;


class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {

  UserApiService userApiService;

  SharedPreferences sharedPreferences;

  bool _isPasswordVisible = true;
  bool _isPasswordVisibleTwo = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountNameController =
      new TextEditingController();
  final TextEditingController _passwordOneController =
      new TextEditingController();
  final TextEditingController _passwordTwoController =
      new TextEditingController();
  String _account;
  String _passwordOne;
  String _passwordTwo;

  String firstName;
  String lastName;
  String email;
  String accountName;
  String password;

  @override
  void initState() {
    super.initState();
    checkStorageStatus();
    userApiService = UserApiService();
  }

  checkStorageStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  createUserRequest(String firstName, lastName, email, accountName, password) async{
    Map data = {
      "firstName":firstName,
      "lastName":lastName,
      "email":email,
      "accountName":accountName,
      "password":password
    };

    var jsonResponse;
    var url = Constant.baseURL + 'user';
    print(url);
    var response = await http.post(url, body:data);

    if(response.statusCode == 200){
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      sharedPreferences.setInt('newUserId', jsonResponse['id']);
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => VerificationScreen()),
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

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Scaffold(
            body: CircularProgressIndicator()
          );
        }
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
                        child: _headerSection())
                  ],
                ),
                Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      children: <Widget>[
                        _buildAccountName(),
                        SizedBox(height: 40.0),
                        _buildPasswordOne(),
                        SizedBox(height: 40.0),
                        _buildPasswordTwo(),
                        SizedBox(height: 40.0),
                        _infoText(),
                        SizedBox(height: 40.0),
                        new Container(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 55.0,
                            child: RaisedButton(
                              onPressed: () {
                                if (!_formKey.currentState.validate()) {
                                  return null;
                                }
                                createUserRequest(sharedPreferences.getString('firstNameForm'),
                                                  sharedPreferences.getString('lastNameForm'),
                                                  sharedPreferences.getString('emailForm'),
                                                  _accountNameController.text,
                                                  _passwordOneController.text
                                                  );
                              },
                              child: Text(AppTranslations.of(context).text("register"),
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                              color: Colors.red,
                            )
                          )
                        ),
                        SizedBox(height: 40.0),
                        _helpText(),
                      ],
                    ))
              ]))),
      );
    }
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
                    MaterialPageRoute(builder: (context) => BasicScreen()));
              },
            ),
          )
        ],
      ),
    ]));
  }

  Widget _buildAccountName() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 0.8 * width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            Text(
              AppTranslations.of(context).text("register_account_name"),
              style: TextStyle(
                  fontSize: 12.0, color: Color.fromRGBO(136, 136, 136, 1)),
            ),
            IconButton(
              icon: Icon(Icons.help),
              iconSize: 18,
              color: Color.fromRGBO(136, 136, 136, 100),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text('Do uzupełnienia'),
                    );
                  }
                );
              },
              )
            ],
          ),
          TextFormField(
            controller: _accountNameController,
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
              _account = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordOne() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
        width: 0.8 * width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppTranslations.of(context).text("register_password").toUpperCase(),
              style: TextStyle(
                  fontSize: 12.0, color: Color.fromRGBO(136, 136, 136, 1)),
            ),
            TextFormField(
              controller: _passwordOneController,
              obscureText: _isPasswordVisible,
              decoration: InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide()),
                hintStyle: TextStyle(color: Colors.blue),
                suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Color.fromRGBO(136, 136, 136, 1),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    }),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return AppTranslations.of(context).text("validate_empty_field");
                } else
                  return null;
              },
              onSaved: (String value) {
                _passwordOne = value;
              },
            ),
          ],
        ));
  }

  Widget _buildPasswordTwo() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
        width: 0.8 * width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppTranslations.of(context).text("register_confirm_password").toUpperCase(),
              style: TextStyle(
                  fontSize: 12.0, color: Color.fromRGBO(136, 136, 136, 1)),
            ),
            TextFormField(
              controller: _passwordTwoController,
              obscureText: _isPasswordVisibleTwo,
              decoration: InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide()),
                hintStyle: TextStyle(color: Colors.blue),
                suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisibleTwo
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Color.fromRGBO(136, 136, 136, 1),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisibleTwo = !_isPasswordVisibleTwo;
                      });
                    }),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return AppTranslations.of(context).text("validate_empty_field");
                } 
                if(value != _passwordOneController.text){
                  return AppTranslations.of(context).text("register_password_not_same");
                }
                return null;
              },
              onSaved: (String value) {
                _passwordTwo = value;
              },
            ),
          ],
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

  Container _infoText() {
    return Container(
      child: GestureDetector(
        child: Text(
          AppTranslations.of(context).text("register_accept_policy_and_regulations"),
          style: TextStyle(fontSize: 14.0, color: Color.fromRGBO(136, 136, 136, 100)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
