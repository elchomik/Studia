import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {

  AnimationController _controller;


  @override
  void initState() {
    super.initState();
    _controller=AnimationController(
      duration: Duration(milliseconds: 2000),
        vsync: this);
  }


  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future _startAnimation() async{
    try{
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    }on TickerCanceled{
      print('Animation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animations'),
        ),
        body: GestureDetector(
          onTap: (){
            _startAnimation();
          },
          child: Center(
            child: Container(
              width: 350.0,
              height: 350.0,
              decoration: BoxDecoration(
                color:Colors.grey.withOpacity(0.1),
                border: Border.all(
                  color: Colors.blueGrey.withOpacity(0.8),
                ),
              ),
              child: AnimatedBox(


              ),
            ),
          ),
        ),
      ),
    );
  }
}




