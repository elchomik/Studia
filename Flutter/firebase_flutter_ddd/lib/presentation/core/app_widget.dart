import 'package:firebase_flutter_ddd/presentation/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData.light().copyWith(
          primaryColor: Colors.green[800],
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
          inputDecorationTheme: InputDecorationTheme(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(0)))),
      home: const SignInPage(),
    );
  }
}
