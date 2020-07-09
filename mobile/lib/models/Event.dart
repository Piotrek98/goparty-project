import 'dart:convert';

import 'package:prod_name/models/Location.dart';
import 'package:prod_name/models/User.dart';

class Event {
  List<User> takePartUsers;
  List<User> interestedUsers;
  int id;
  String title;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  int interested;
  int takeAparty;
  String description;
  String city;
  String address;
  String entryType;
  int freePlacesCount;
  int distanceTo;
  Location location;
  String partyAvatar;
  User organizer;

  Event(
      {this.takePartUsers,
      this.interestedUsers,
      this.id,
      this.title,
      this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      this.interested,
      this.takeAparty,
      this.description,
      this.city,
      this.address,
      this.entryType,
      this.freePlacesCount,
      this.distanceTo,
      this.location,
      this.partyAvatar,
      this.organizer
      });

  Event.fromJson(Map<String, dynamic> json) {
    if (json['takePartUsers'] != null) {
      takePartUsers = new List<Null>();
      json['takePartUsers'].forEach((v) {
        takePartUsers.add(new User.fromJson(v));
      });
    }
    if (json['interestedUsers'] != null) {
      interestedUsers = new List<Null>();
      json['interestedUsers'].forEach((v) {
        interestedUsers.add(new User.fromJson(v));
      });
    }
    id = json['id'];
    title = json['title'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    endDate = json['endDate'];
    endTime = json['endTime'];
    interested = json['interested'];
    takeAparty = json['takeAparty'];
    description = json['description'];
    city = json['city'];
    address = json['address'];
    entryType = json['entryType'];
    freePlacesCount = json['freePlacesCount'];
    distanceTo = json['distanceTo'];
    // location = json['location'] != null
    //     ? new Location.fromJson(json['location'])
    //     : null;
    // partyAvatar = json['partyAvatar'];
    // organizer = json['organizer'] != null
    //     ? new User.fromJson(json['organizer'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.takePartUsers != null) {
      data['takePartUsers'] =
          this.takePartUsers.map((v) => v.toJson()).toList();
    }
    if (this.interestedUsers != null) {
      data['interestedUsers'] =
          this.interestedUsers.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['title'] = this.title;
    data['startDate'] = this.startDate;
    data['startTime'] = this.startTime;
    data['endDate'] = this.endDate;
    data['endTime'] = this.endTime;
    data['interested'] = this.interested;
    data['takeAparty'] = this.takeAparty;
    data['description'] = this.description;
    data['city'] = this.city;
    data['address'] = this.address;
    data['entryType'] = this.entryType;
    data['freePlacesCount'] = this.freePlacesCount;
    data['distanceTo'] = this.distanceTo;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['partyAvatar'] = this.partyAvatar;
    if (this.organizer != null) {
      data['organizer'] = this.organizer.toJson();
    }
    return data;
  }
}

List<Event> eventsFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<Event>.from(data.map((item) => Event.fromJson(item)));
}

Event eventFromJson(String jsonData){
  final data = json.decode(jsonData);
  return Event.fromJson(data);
}

String eventToJson(Event data){
  final jsonData = data.toJson();
  return json.encode(jsonData);
}