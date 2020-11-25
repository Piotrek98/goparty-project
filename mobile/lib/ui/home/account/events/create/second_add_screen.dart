import 'dart:async';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prod_name/constants/Constants.dart' as Constants;
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/home/account/events/create/third_add_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondAddScreen extends StatefulWidget {

  final String url = 'http://10.0.2.2:80/file/create';

  @override
  _SecondAddScreenState createState() => _SecondAddScreenState();
}
//TODO: dodac tlumaczenie tutaj KURWA!
class _SecondAddScreenState extends State<SecondAddScreen> {
  final _formKey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  DateTime pickedDate;
  TimeOfDay time;
  
  String state = "";
  String labelDateFrom = Constants.NO_DATE_SELECTED;
  String labelTimeFrom = Constants.NO_TIME_SELECTED;
  String labelDateTo = Constants.NO_DATE_SELECTED;
  String labelTimeTo = Constants.NO_TIME_SELECTED;
  String formattedDateFrom = '';
  String formattedDateTo = '';
  String correctTimeFrom = '';
  String correctTimeTo = '';
  String imageName = Constants.NO_PICTURE_SELECTED;
  int freePlaces = 10000;

  List<String> _categories = [Constants.ENTRYTYPE_FREE, Constants.ENTRYTYPE_LIMITED];
  String _selectedCategory;

  bool droDownSelected = false;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  saveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('dateFrom', formattedDateFrom);
    sharedPreferences.setString('timeFrom', labelTimeFrom);
    sharedPreferences.setString('dateTo', formattedDateTo);
    sharedPreferences.setString('timeTo', labelTimeTo);
  
  //TODO: plik constant, wrzucic to do zmiennych
    if(_selectedCategory == Constants.ENTRYTYPE_FREE){
      sharedPreferences.setString('eventType', Constants.FREE);
      sharedPreferences.setInt('freePlaces', freePlaces);
    }else if(_selectedCategory == Constants.ENTRYTYPE_LIMITED){
      sharedPreferences.setString('eventType', Constants.LIMITED);
      sharedPreferences.setInt('freePlaces', int.parse(_countPersonOnEventController.text));
    }
  }

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    return res.reasonPhrase;
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
                          dateFrom(),
                          SizedBox(height: 30),
                          dateTo(),
                          SizedBox(height: 50),
                          eventTypeAndCount(),
                          SizedBox(height: 50),
                          addImge(), 
                          SizedBox(height: 50),
                          _buttonSection()
                      ],
                    ))
              ]))),
    );
  }

 Widget addImge(){
   return Container(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
              AppTranslations.of(context).text("event_add_picture"), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.add_photo_alternate),
                onTap: () async {
                  var file = await ImagePicker.pickImage(source: ImageSource.gallery);
                  var json = await uploadImage(file.path, widget.url);
                  setState(() {
                    state = json;
                    // sharedPreferences.setInt('imageID', json['id']);

                    if(json != null){
                      imageName = AppTranslations.of(context).text("event_upload_picture");
                    }
                  }); 
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  imageName
              ))
            ],
          ),
       ],
     ),
   );
 }

 Widget dateFrom(){
   return Container(
     child: Column(
       children: <Widget>[
         Row(
           children: <Widget>[
              Text(AppTranslations.of(context).text("event_start_date_time"), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
           ],
         ),
         SizedBox(height: 10),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             GestureDetector(
               child: Row(
                 children: <Widget>[
                   Icon(Icons.calendar_today),
                   SizedBox(width: 10),
                   Text(labelDateFrom)
                 ],
               ),
               onTap: () {
                 _pickDateFrom();
               },
             ),
             GestureDetector(
               child: Row(
                 children: <Widget>[
                   Icon(Icons.access_time),
                   SizedBox(width: 10),
                   Text(labelTimeFrom)
                 ],
               ),
               onTap: () {
                 _pickTimeFrom();
               },
             ),
           ],
         )
       ],
     )
   );
 }

 Widget dateTo(){
   return Container(
     child: Column(
       children: <Widget>[
         Row(
           children: <Widget>[
              Text(AppTranslations.of(context).text("event_end_date_time"), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
           ],
         ),
         SizedBox(height: 10),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             GestureDetector(
               child: Row(
                 children: <Widget>[
                   Icon(Icons.calendar_today),
                   SizedBox(width: 10),
                   Text(labelDateTo)
                 ],
               ),
               onTap: () {
                 _pickDateTo();
               },
             ),
             GestureDetector(
               child: Row(
                 children: <Widget>[
                   Icon(Icons.access_time),
                   SizedBox(width: 10),
                   Text(labelTimeTo)
                 ],
               ),
               onTap: () {
                 _pickTimeTo();
               },
             ),
           ],
         )
       ],
     )
   );
 }

  _pickDateFrom() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().day - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: pickedDate
    );

    if(date != null){
      var dateNow = DateTime.parse(date.toString());
      var formattedDateFormat = "${dateNow.day}/${dateNow.month}/${dateNow.year}";
      setState(() {
        formattedDateFrom = formattedDateFormat;

        if(formattedDateFrom != null){
          labelDateFrom = formattedDateFrom;
        }

        print(formattedDateFrom);
      });
    }
  }

  _pickTimeFrom() async {
    TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: time
    );

    if(timeOfDay != null){
      String correctTimeFrom = timeOfDay.toString().substring(10, 15);
      setState(() {
        time = timeOfDay;
        if(correctTimeFrom != null){
          labelTimeFrom = correctTimeFrom;
        }

        print(correctTimeFrom);
      });
    }
  }

  _pickDateTo() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().day - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: pickedDate
    );

    if(date != null){
      var dateNow = DateTime.parse(date.toString());
      var formattedDateFormat = "${dateNow.day}/${dateNow.month}/${dateNow.year}";
      setState(() {
        formattedDateTo = formattedDateFormat;

        if(formattedDateTo != null){
          labelDateTo = formattedDateTo;
        }

        print(formattedDateTo);
      });
    }
  }

  _pickTimeTo() async {
    TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: time
    );

    if(timeOfDay != null){
      String correctTimeTo = timeOfDay.toString().substring(10, 15);
      setState(() {
        time = timeOfDay;
        if(correctTimeTo != null){
          labelTimeTo = correctTimeTo;
        }

        print(correctTimeTo);
      });
    }
  }

  Widget eventTypeAndCount(){
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                AppTranslations.of(context).text("event_entry_type"), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          _dropdownCategory(),
          SizedBox(height: 30),
          droDownSelected ? _buildCountPerson() : SizedBox()
        ],
      ),
    );
  }

  Widget _dropdownCategory(){
    return Container(
      child: DropdownButton(
      isExpanded: true,
      hint: Text(AppTranslations.of(context).text("event_choose_category"), style: TextStyle(color: Colors.grey.shade300),),
      value: _selectedCategory,

      onChanged: (newValue) {
        setState((){
          _selectedCategory = newValue;
          if(_selectedCategory == 'Liczba miejsc ograniczona'){
            droDownSelected = true;
          }else{
            droDownSelected = false;
          }

        });
      },
      items: _categories.map((category){
        return DropdownMenuItem(
          child: new Text(category, style: TextStyle(color: Colors.black),),
          value: category,

        );
      }).toList(),
    )
    );
  }

  TextEditingController _countPersonOnEventController = new TextEditingController();
  // String _count;

  _buildCountPerson(){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Row(
        children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(AppTranslations.of(context).text("event_place_number"), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
              SizedBox(
                width: 120,
                height: 50,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _countPersonOnEventController,
                  decoration: InputDecoration(
                    hintText: '0',
                        border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)
                      ),
                  ),
                  validator: (String value) {
                      if(value.isEmpty){
                        return AppTranslations.of(context).text("validate_empty_field");
                      }else return null;
                    },
                  )
              )
              
        ],
      ));
  }



  Container _buttonSection() {
    return Container(
        child: SizedBox(
        height: 55.0,
        width: MediaQuery.of(context).size.width * 0.4,
        child: RaisedButton(
          onPressed: () {
            // if (!_formKey.currentState.validate()) {
            //   return;
            // }
            saveData();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ThirdAddScreen()));
          },
          child: Text(AppTranslations.of(context).text("event_next_page"),
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          color: Colors.green
        ),
      )
    );
  }
}
