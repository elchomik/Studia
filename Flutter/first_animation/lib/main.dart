import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  Animation animation;
  AnimationController animationController;


  @override
  void initState() {
    super.initState();
    animationController=AnimationController(
      duration: Duration(milliseconds: 5000),
        vsync:this);

    animation=Tween(begin: 0.0,end: 500.0).animate(animationController);

    animationController.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        animationController.reverse();
      }
      else if(status==AnimationStatus.dismissed){
        animationController.forward();
      }
    });
    animationController.forward();

  }

  @override
  Widget build(BuildContext context) {
    return LogoAnimation(
      animation: animation,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}


class LogoAnimation extends AnimatedWidget{
  LogoAnimation({Key key,Animation animation})
  :super(key: key,listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation animation=listenable;
    return Center(
      child: Container(
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }


}

