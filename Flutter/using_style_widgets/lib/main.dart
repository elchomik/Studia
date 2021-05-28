import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Transform(
              transform: Matrix4.identity(),
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color(0xffef5350),
                      Color(0x00ef5350),
                    ],
                  ),
                 /* boxShadow: [
                    BoxShadow(
                      color: Color(0xcc000000),
                      offset: Offset(0.0,2.0),
                      blurRadius: 4.0
                    ),
                    BoxShadow(
                      color: Color(0x80000000),
                      offset: Offset(3.0,6.0),
                      blurRadius: 2.0,
                    )
                  ],*/
                  /*borderRadius: BorderRadius.circular(1000.0),
                  border: Border.all(
                    color: Colors.black,
                  )

                */
                  shape: BoxShape.rectangle,
                ),
                alignment: Alignment.center,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                    ),
                    children: [
                      TextSpan(text: "Styling a bounch of widgets ",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w100,
                      )
                      ),
                      TextSpan(text: "Stuff in Flutter",
                      style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w900
                      ),
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


