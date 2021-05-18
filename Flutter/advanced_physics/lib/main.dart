import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'dart:math';

import 'home_page.dart';

const BOX_COLOR=Colors.cyan;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: "Spring Box",
    theme: ThemeData(
      primaryColor: Colors.red,
  ),
  home: HomePage(),
    );
  }
}
