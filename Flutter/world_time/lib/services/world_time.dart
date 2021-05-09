import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WorldTime{

  String location; //location name for the UI
  String time; //time in that location
  String flag; //URL to an asset flag icon
  String url;//location url for api endpoint

  WorldTime({this.location, this.flag,
      this.url});


  Future<void> getTime() async { //asynchronous function

    try {
      Response response = await get(
          Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);


      //get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);


      //create Datetime object

      DateTime now = DateTime.parse(data['datetime']);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      time = now.toString();
    }catch(e){
      print("caught error :$e");
      time='could not get time data';

    }
  }
}

