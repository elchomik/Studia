import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      title: "Random Square",
      home: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Random _random=Random();
  Color color=Colors.amber;
  int counter=0;
  void onTap(){
    setState(() {
      counter++;
      color=Color.fromRGBO(
          _random.nextInt(256),
          _random.nextInt(256),
          _random.nextInt(256),
          _random.nextDouble());

    });
  }


  @override
  Widget build(BuildContext context) {
    return ColorState(
      color: color,
      onTap: onTap,
      counter:counter,
      child: BoxTree(),
    );
  }
}

class BoxTree  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Box(),
                Box(),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Box(),
                Box(),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Box(),
                Box(),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Box(),
                Box(),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class Box extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorState=ColorState.of(context);
    return Padding(
      padding: const EdgeInsets.only(top:40),
      child: GestureDetector(
        onTap: colorState.onTap,
        onLongPress:(){
          print("Long pressed");
        },
        child: Container(
          width: 100.0,
          height: 100.0,
          margin: EdgeInsets.only(left:50),
          color: colorState.color,
          child: Padding(
            padding: const EdgeInsets.only(top:40,left:40),
            child: Text("${colorState.counter}",
            style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            ),
            ),
          ),
        ),
      ),
    ) ;
  }
}

class ColorState extends InheritedWidget{

  ColorState({
    Key key,this.color,this.onTap,
    this.counter,
    Widget child,
}):super(key: key,child: child);

  final Color color;
  final Function onTap;
  int counter;

  @override
  bool updateShouldNotify(ColorState oldWidget) {
    return color!=oldWidget.color;
  }

   static ColorState of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType(aspect: ColorState);
  }


}


