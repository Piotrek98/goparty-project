import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:prod_name/api/user_api_service.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/home/account/user/user_screen.dart';
import 'package:prod_name/ui/home/home/home_screen.dart';
import 'package:prod_name/ui/home/map/map_screen.dart';
import 'package:prod_name/ui/home/search/search_screen.dart';
import 'package:prod_name/ui/start/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationScreen extends StatefulWidget{
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>{
  final _formKey = GlobalKey<FormState>();

  UserApiService userApiService;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkStorageStatus();
    userApiService = UserApiService();
  }

  checkStorageStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
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
      body: Builder(
        builder: (BuildContext context){
        return SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 40.0),
                        _headerText(),
                        SizedBox(height: 40.0),
                        _infoText(),
                        SizedBox(height: 60.0),
                        _pinCode(),
                        SizedBox(height: 90.0),
                        new Container(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 55.0,
                            child: RaisedButton(
                              onPressed: () async {
                                bool activateAccount = await userApiService.activateAccount(sharedPreferences.getInt('newUserId'), int.parse(activeCode));
                                if(activateAccount){
                                  final snackBar = SnackBar(
                                    duration: const Duration(seconds: 2),
                                    content: Text(AppTranslations.of(context).text("register_activate_account_success")),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                }else{
                                  final snackBar = SnackBar(
                                    content: Text(AppTranslations.of(context).text("register_incorrect_password")),
                                  );

                                  Scaffold.of(context).showSnackBar(snackBar);
                                }
                                sharedPreferences.clear(); 
                              },
                              child: Text(AppTranslations.of(context).text("register_confirm"),
                                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                              color: Colors.red,
                            )
                          )
                        ),
                        SizedBox(height: 20.0),
                        _omitText(),
                        SizedBox(height: 20.0),
                        _helpText(),
                      ],
                    ))
              ])));}),
      );
    }
    );
  }

  String activeCode;

  Widget _pinCode(){
    return PinCodeTextField(
      length: 4,
      shape: PinCodeFieldShape.box,
      backgroundColor: Colors.black.withOpacity(0),
      borderRadius: BorderRadius.circular(10),
      fieldHeight: 50,
      fieldWidth: 50,
      activeColor: Colors.red,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      onCompleted: (value) async {
        setState(() {
          activeCode = value;
        });
      },
      onChanged: (value) {
        return null;
      },
    );
  }

  Container _headerText() {
    return Container(
      child: GestureDetector(
        child: Text(
          AppTranslations.of(context).text("register_verification_title"),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30, 
              color: Color.fromRGBO(136, 136, 136, 100),
              fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Container _infoText() {
    return Container(
      child: GestureDetector(
        child: Text(
          AppTranslations.of(context).text("register_verification_description"),
          style: TextStyle(
              fontSize: 14, 
              color: Color.fromRGBO(136, 136, 136, 100),
              // fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
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

  Container _omitText() {
    return Container(
      child: GestureDetector(
        child: Text(
           AppTranslations.of(context).text("register_omit"),
          style: TextStyle(
              fontSize: 14, color: Color.fromRGBO(136, 136, 136, 100)),
        ),
        onTap: (){
           Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));}
      ),
    );
  }
}