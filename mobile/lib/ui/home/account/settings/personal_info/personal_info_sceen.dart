import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/home/account/user/user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:prod_name/constants/Constants.dart' as Constants;

class PersonalInfoScreen extends StatefulWidget {
  final String url = 'http://10.0.2.2:80/file/create';

  @override
  PersonalInfoScreenState createState() => PersonalInfoScreenState();
}

class PersonalInfoScreenState extends State<PersonalInfoScreen> {
  SharedPreferences sharedPreferences;
  Future _future;
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController accountNameController = new TextEditingController();
  String imageName = Constants.NO_PICTURE_SELECTED;
  String state;
  final _formKeyFirstName = GlobalKey<FormState>();
  final _formKeyLastName = GlobalKey<FormState>();
  final _formKeyAccountName = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _future = checkStorageStatus();
  }

  checkStorageStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  Future<bool> editFirstname(String firstName) async {
    Map<String, String> data = {"firstName": firstName};

    int id = sharedPreferences.getInt("id");

    var url = 'http://10.0.2.2:80/user/${id}';
    var response = await http.patch(url, body: data);
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  Future<bool> editLastname(String lastName) async {
    Map<String, String> data = {"lastName": lastName};

    int id = sharedPreferences.getInt("id");

    var url = 'http://10.0.2.2:80/user/${id}';
    var response = await http.patch(url, body: data);
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  Future<bool> editAccountname(String accountName) async {
    Map<String, String> data = {"accountName": accountName};

    int id = sharedPreferences.getInt("id");

    var url = 'http://10.0.2.2:80/user/${id}';
    var response = await http.patch(url, body: data);
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
              AppTranslations.of(context).text("settings_personal_info"),
              style: TextStyle(color: Colors.black, letterSpacing: 1)),
          elevation: 0.0,
          centerTitle: true,
          bottom: PreferredSize(
            child: Container(color: Colors.black, height: 0.1),
            preferredSize: Size.fromHeight(0.1),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              infoText(),
              SizedBox(height: 60.0),
              _buildFirstName(),
              SizedBox(height: 40.0),
              _buildLastName(),
              SizedBox(height: 40.0),
              _buildAccountName(),
              SizedBox(height: 40.0),
              addImge(),
              SizedBox(height: 40.0),
            ],
          ),
        )));
  }

  Widget infoText() {
    return Container(
      child: Row(
        children: <Widget>[
          Text(AppTranslations.of(context).text("settings_personal_info_about"),
              style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }

  String firstNameText;
  String lastNameText;
  String accountNameText;
  String _firstName;
  String _lastName;
  String _accountName;

  Widget _buildFirstName() {
    double width = MediaQuery.of(context).size.width;
    return Form(
        key: _formKeyFirstName,
        child: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              return SizedBox(
                width: 0.8 * width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppTranslations.of(context)
                          .text("user_first_name")
                          .toUpperCase(),
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(136, 136, 136, 1)),
                    ),
                    TextFormField(
                      style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1)),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.green,
                            onPressed: () async {
                              if (!_formKeyFirstName.currentState.validate()) {
                                return;
                              }
                              bool editUser =
                                  await editFirstname(firstNameText);
                              if (editUser) {
                                final snackBar = SnackBar(
                                  duration: const Duration(seconds: 3),
                                  content: Text(AppTranslations.of(context)
                                      .text("settings_personl_info_confirm")),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              }
                            },
                          ),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide()),
                          hintStyle: TextStyle(color: Colors.grey.shade300),
                          hintText: sharedPreferences.getString("firstName")),
                      onChanged: (String value) {
                        setState(() {
                          if (value == null) {
                            firstNameText =
                                sharedPreferences.getString("firstName");
                          } else {
                            firstNameText = value;
                          }
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppTranslations.of(context)
                              .text("validate_empty_field");
                        }
                      },
                      onSaved: (String value) {
                        _firstName = value;
                      },
                    ),
                  ],
                ),
              );
            }));
  }

  Widget _buildLastName() {
    double width = MediaQuery.of(context).size.width;
    return Form(
        key: _formKeyLastName,
        child: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              return SizedBox(
                width: 0.8 * width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppTranslations.of(context)
                          .text("user_last_name")
                          .toUpperCase(),
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(136, 136, 136, 1)),
                    ),
                    TextFormField(
                      // controller: lastNameController,
                      style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1)),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.green,
                            onPressed: () async {
                              if (!_formKeyLastName.currentState.validate()) {
                                return;
                              }
                              bool editUser = await editLastname(lastNameText);
                              if (editUser) {
                                final snackBar = SnackBar(
                                  duration: const Duration(seconds: 3),
                                  content: Text(AppTranslations.of(context)
                                      .text("settings_personl_info_confirm")),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else {}
                            },
                          ),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide()),
                          hintStyle: TextStyle(color: Colors.grey.shade300),
                          hintText: sharedPreferences.getString("lastName")),
                      onChanged: (String value) {
                        setState(() {
                          if (value == null) {
                            lastNameText =
                                sharedPreferences.getString("lastName");
                          } else {
                            lastNameText = value;
                          }
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppTranslations.of(context)
                              .text("validate_empty_field");
                        }
                      },
                      onSaved: (String value) {
                        _lastName = value;
                      },
                    ),
                  ],
                ),
              );
            }));
  }

  Widget _buildAccountName() {
    double width = MediaQuery.of(context).size.width;
    return Form(
        key: _formKeyAccountName,
        child: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              return SizedBox(
                width: 0.8 * width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppTranslations.of(context)
                          .text("user_account_name")
                          .toUpperCase(),
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(136, 136, 136, 1)),
                    ),
                    TextFormField(
                      // controller: accountNameController,
                      style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1)),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            color: Colors.green,
                            onPressed: () async {
                              if (!_formKeyAccountName.currentState.validate()) {
                                return;
                              }
                              bool editUser =
                                  await editAccountname(accountNameText);
                              if (editUser) {
                                final snackBar = SnackBar(
                                  duration: const Duration(seconds: 3),
                                  content: Text(AppTranslations.of(context)
                                      .text("settings_personl_info_confirm")),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else {}
                            },
                          ),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide()),
                          hintStyle: TextStyle(color: Colors.grey.shade300),
                          hintText: sharedPreferences.getString("accountName")),
                      onChanged: (String value) {
                        setState(() {
                          if (value == null) {
                            accountNameText =
                                sharedPreferences.getString("accountName");
                          } else {
                            accountNameText = value;
                          }
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppTranslations.of(context)
                              .text("validate_empty_field");
                        }
                      },
                      onSaved: (String value) {
                        _accountName = value;
                      },
                    ),
                  ],
                ),
              );
            }));
  }

  Widget addImge() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                AppTranslations.of(context).text("settings_personl_info_image"),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.add_photo_alternate),
                onTap: () async {
                  var file =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  var json = await uploadImage(file.path, widget.url);
                  setState(() {
                    state = json;
                    // sharedPreferences.setInt('imageID', json['id']);

                    if (json != null) {
                      imageName = AppTranslations.of(context)
                          .text("event_upload_picture");
                    }
                  });
                },
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10), child: Text(imageName))
            ],
          ),
        ],
      ),
    );
  }
}
