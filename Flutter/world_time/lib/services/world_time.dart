import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; //location name for the UI
  String time; //time in that location
  String flag; //URL to an asset flag icon
  String url;//location url for api endpoint
  bool isDayLine; //true or false if dayline or not

  WorldTime({this.location, this.flag,
      this.url});
  Map data;

  Future<void> getTime() async { //asynchronous function

  //  do {
      try {
        http.Response response= await http.get(
            Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
        Map data = jsonDecode(response.body);


        //get properties from data
        String dateTime = data['datetime'];
        String offset = data['utc_offset'].substring(1, 3);


        //create Datetime object

        DateTime now = DateTime.parse(dateTime);
        now = now.add(Duration(hours: int.parse(offset)));

        //set the time property
        isDayLine = now.hour > 6 && now.hour < 20 ? true : false;
        time = DateFormat.jm().format(now);
      } catch (e) {
        print("caught error :$e");
        time = 'could not get time data';
      }
   // }while(null==isDayLine);
  }
}

