import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/service/languages/Application.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  // SharedPreferences sharedPreferences;

  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;


  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(AppTranslations.of(context).text("settings_language"), style: TextStyle(color: Colors.black, letterSpacing: 1)),
            elevation: 0.0,
            centerTitle: true,
            bottom: PreferredSize(child: Container(color: Colors.black, height: 0.1), preferredSize: Size.fromHeight(0.1),),
          ),
      body: _buildLanguagesList()
    );
  }

  @override
  void initState(){
    super.initState();
    // getCurrentLanguage();
  }

  // Future<String> getCurrentLanguage() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  // }

  String selectedLanguage;
  String currentLanguage;
  bool _langOne = false;
  bool _langTwo = false;


  _buildLanguagesList() {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(AppTranslations.of(context).text("settings_current_language"), style: TextStyle(fontSize: 22),),
                ),
                CheckboxListTile(
                  title: Text(languagesList[0]),
                  value: _langOne,
                  onChanged: (value) {
                    setState(() {
                      _langOne = value;
                      if(_langOne){
                        _langTwo = false;
                      }  
                      application.onLocaleChanged(Locale(languagesMap[languagesList[0]]));
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text(languagesList[1]),
                  value: _langTwo,
                  onChanged: (value) {
                    setState(() {
                      _langTwo = value;
                      if(_langTwo){
                        _langOne = false;
                      }
                      application.onLocaleChanged(Locale(languagesMap[languagesList[1]]));
                    });
                  },
                )
              ],
      )
    );
  }
}