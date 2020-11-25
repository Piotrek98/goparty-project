import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/home/nav_bar.dart';
import 'package:prod_name/ui/start/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prod_name/constants/Constants.dart' as Constant;


class LoginScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  bool _isLoading = false;

  Future<bool> makeLoginRequest(String email, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': emailController.text,
      'password': passwordController.text
    };
    var jsonResponse;
    var url = Constant.baseURL;
    var response = await http.post(url, body: data);
    print(response.body);
    if (response.statusCode == 200) {
      _isLoading = false;
      jsonResponse = json.decode(response.body);
      sharedPreferences.setInt("id", jsonResponse['id']);
      sharedPreferences.setString("firstName", jsonResponse['firstName']);
      sharedPreferences.setString("lastName", jsonResponse['lastName']);
      sharedPreferences.setString("accountName", jsonResponse['accountName']);
      sharedPreferences.setInt("countFollowedBy", jsonResponse['countFollowedBy']);
      sharedPreferences.setInt("countMyFollows", jsonResponse['countMyFollows']);
      // sharedPreferences.setString("profileImage", jsonResponse['profileImage']['content']);
      setState((){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => NavBar()),
            (Route<dynamic> route) => false);
      });
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: _headerSection(),
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        children: <Widget>[
                          // _graphicSection(),
                          // loadImage(),
                          SizedBox(height: 120.0), //TODO
                          _buildEmail(),
                          SizedBox(height: 30.0),
                          _buildPassword(),
                          SizedBox(height: 80.0),
                          new Container(
                              child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 55.0,
                            child: RaisedButton(
                              onPressed: () async {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                setState(() {
                                  _isLoading = true;
                                });
                                bool loginAction = await makeLoginRequest(
                                    emailController.text,
                                    passwordController.text);

                                if (!loginAction) {
                                  final snackBar = SnackBar(
                                    duration: const Duration(seconds: 5),
                                    content: Text(AppTranslations.of(context).text("login_incorrect_password_email")),
                                  );

                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {}
                              },
                              child: Text(AppTranslations.of(context).text("login").toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0)),
                              color: Colors.orange,
                            ),
                          )),
                          SizedBox(height: 40.0),
                          _helpText(),
                        ],
                      ))
                ])));
      }),
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

  // Container _graphicSection() {
  //   final String graphic = 'assets/graphic/two_people.svg';
  //   return Container(
  //       child: Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.max,
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: <Widget>[
  //       SvgPicture.asset(
  //         graphic,
  //         height: 150,
  //         alignment: Alignment.center,
  //       )
  //     ],
  //   ));
  // }

  loadImage() async {
    final String graphic = 'assets/graphic/two_people.svg';
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SvgPicture.asset(
          graphic,
          height: 150,
          alignment: Alignment.center,
        )
      ],
    )
    );
  }

  // Widget graphic(){
  //   final String graphic = 'assets/graphic/two_people.svg';
  //   return FutureBuilder(
  //     builder: (BuildContext context, snapshot){
  //       return Container(
  //         child: Column(
  //           children: <Widget>[
  //             precachePicture(
  //               SvgPicture.asset('assets/graphic/two_people.svg'), context);
  //           ],
  //         ),
  //       )
  //     },
  //   )
  // }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool _isPasswordVisible = true;

  Widget _buildEmail() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 0.8 * width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppTranslations.of(context).text("login_email").toUpperCase(),
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
            onChanged: (String value){
              final trimValue = value.trim();
              if(value != trimValue){
                setState(() {
                  emailController.text = trimValue;
                });
              }
            },
            validator: (String value) {
              if (value.isEmpty) {
                return AppTranslations.of(context).text("validate_empty_field");
              }
              if (!value.contains('@')) {
                return  AppTranslations.of(context).text("login_incorrect_password");
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

  Widget _buildPassword() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
        width: 0.8 * width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppTranslations.of(context).text("login_password").toUpperCase(),
              style: TextStyle(
                  fontSize: 12.0, color: Color.fromRGBO(136, 136, 136, 1)),
            ),
            TextFormField(
              controller: passwordController,
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
                _password = value;
              },
            ),
            Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      child: Text(
                        AppTranslations.of(context).text("login_password_forgot").toUpperCase(),
                        style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(136, 136, 136, 1)),
                      ),
                      onTap: () {
                        ///
                      },
                    )
                  ],
                ))
          ],
        ));
  }

  Container _helpText() {
    return Container(
      child: GestureDetector(
        child: Text(
          AppTranslations.of(context).text("login_help_ask"),
          style: TextStyle(
              fontSize: 12, color: Color.fromRGBO(136, 136, 136, 100)),
        ),
      ),
    );
  }
}
