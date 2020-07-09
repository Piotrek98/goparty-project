import 'dart:convert';

import 'package:prod_name/models/Event.dart';
import 'package:prod_name/models/Notification.dart';
import 'package:prod_name/models/Observations.dart';

class User {
  List<Event> myEvents;
  List<Event> getInvolvedEvents;
  List<Event> myInterestedEvents;
  List<Observations> followedBy;
  List<Observations> myFollows;
  List<Notification> notifications;
  int id;
  String firstName;
  String lastName;
  String accountName;
  String email;
  bool active;
  int activateCode;
  bool admin;
  double latitude;
  double longitude;
  String profileImage;
  int countFollowedBy;
  int countMyFollows;

  User(
      {this.myEvents,
      this.getInvolvedEvents,
      this.myInterestedEvents,
      this.followedBy,
      this.myFollows,
      this.notifications,
      this.id,
      this.firstName,
      this.lastName,
      this.accountName,
      this.email,
      this.active,
      this.activateCode,
      this.admin,
      this.latitude,
      this.longitude,
      this.profileImage,
      this.countFollowedBy,
      this.countMyFollows});


  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      accountName: json['accountName'],
      email: json['email'],
      active: json['active'],
      activateCode: json['activateCode'],
      countFollowedBy: json['countFollowedBy'],
      countMyFollows: json['countMyFollows'],
      admin: json['admin'],
      // latitude: json['latitude'],
      // longitude: json['longitude'],
      followedBy: parseFollowedBy(json),
      myFollows: parseMyFollows(json),
      myEvents: parseMyEvents(json),
      getInvolvedEvents: parseInvolvedEvents(json),
      myInterestedEvents: parseMyInterested(json)
    );
  }

  static List<Observations> parseFollowedBy(json){
    var lista = json['followedBy'] as List;
    List<Observations> followedByList = lista.map((data) => Observations.fromJson(data)).toList();
    return followedByList;
  }  
  
  static List<Observations> parseMyFollows(myFollowsJson){
    var list = myFollowsJson['myFollows'] as List;
    List<Observations> myFollowsList = list.map((data) => Observations.fromJson(data)).toList();
    return myFollowsList;
  }

  static List<Event> parseMyEvents(myEventsJson){
    var list = myEventsJson['myEvents'] as List;
    List<Event> myEventsList = list.map((data) => Event.fromJson(data)).toList();
    return myEventsList;
  }

  static List<Event> parseInvolvedEvents(involvedEventsJson){
    var list = involvedEventsJson['getInvolvedEvents'] as List;
    List<Event> myInvolvedList = list.map((data) => Event.fromJson(data)).toList();
    return myInvolvedList;
  }

  
  static List<Event> parseMyInterested(interestedJson){
    var list = interestedJson['myInterestedEvents'] as List;
    List<Event> myInterestedList = list.map((data) => Event.fromJson(data)).toList();
    return myInterestedList;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myEvents != null) {
      data['myEvents'] = this.myEvents.map((v) => v.toJson()).toList();
    }
    if (this.getInvolvedEvents != null) {
      data['getInvolvedEvents'] =
          this.getInvolvedEvents.map((v) => v.toJson()).toList();
    }
    if (this.myInterestedEvents != null) {
      data['myInterestedEvents'] =
          this.myInterestedEvents.map((v) => v.toJson()).toList();
    }
    // if (this.followedBy != null) {
    //   data['followedBy'] = this.followedBy.map((v) => v.toJson()).toList();
    // }
    // if (this.myFollows != null) {
    //   data['myFollows'] = this.myFollows.map((v) => v.toJson()).toList();
    // }
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['accountName'] = this.accountName;
    data['email'] = this.email;
    data['active'] = this.active;
    data['activateCode'] = this.activateCode;
    data['admin'] = this.admin;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['profileImage'] = this.profileImage;
    data['countFollowedBy'] = this.countFollowedBy;
    data['countMyFollows'] = this.countMyFollows;

    return data;
  }
}

List<User> usersFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<User>.from(data.map((item) => User.fromJson(item)));
}

User userFromJson(String jsonData){
  final data = json.decode(jsonData);
  return User.fromJson(data);
}

String userToJson(User data){
  final jsonData = data.toJson();
  return json.encode(jsonData);
}