import 'package:flutter/material.dart';

import 'input_box.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Input Boxes',
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      home: InputBox(),
    );
  }
}


