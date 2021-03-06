import 'package:flutter/material.dart';
import 'form_screen.dart';
import 'home.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Form Project",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute:'/',
      routes: {
        '/':(context)=>Home(),
        '/form':(context)=>FormScreen(),
      },
    );
  }
}


