import 'package:flutter/material.dart';

class MainState extends InheritedWidget{

  MainState({
    Key key,
    this.inputValue,
    this.prevValue,
    this.value,
    this.op,
    this.onPressed,
    Widget child,
}):super(key: key, child: child);

  final String inputValue;
  final double prevValue;
  final String value;
  final String op;
  final Function onPressed;

  @override
  bool updateShouldNotify(MainState oldWidget) {
    return inputValue!=oldWidget.inputValue;
  }

  static MainState of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType(aspect: MainState);
  }



}