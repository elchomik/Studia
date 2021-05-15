import 'package:dynamic_lists_streams/photo.dart';
import 'package:dynamic_lists_streams/photo_list.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Streamer',
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      home: PhotoList(),
    );
  }
}



