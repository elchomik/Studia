import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

import 'chat.dart';

final ThemeData iOSTheme=ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.grey[400],
  primaryColorBrightness: Brightness.dark,
);

final ThemeData androidTheme=ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.green[100],
);



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Application',
      theme: defaultTargetPlatform ==TargetPlatform.iOS
      ?iOSTheme: androidTheme,
      home: Chat(),
    );
  }
}


