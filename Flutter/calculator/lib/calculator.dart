import 'package:calculator/calculator_layout.dart';
import 'package:calculator/main_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String inputString="";
  double prevValue;
  String value="";
  String op='z';
  int counter=0;

  bool isNumber(String input){

    if(input==null){
      return false;
    }
    return double.parse(input)!=null;
  }

  void onPressed(keyvalue){
    switch(keyvalue){
      case "C":
        {
          op = null;
          prevValue = 0.0;
          value="";
          setState(()=>inputString="");
          break;
        }
      case ".":
      case "%":
      case "<=":
        break;
      case "+/-":
        setState(() {
          inputString=((-1)*double.parse(inputString)).toStringAsFixed(0);
        });
        break;
      case "/":
      case "x":
      case "-":
      case "+":
        op=keyvalue;
        value='';
        prevValue=double.parse(inputString);
        setState(() {
          counter=0;
          inputString=inputString+keyvalue;
        });
        break;
      case "=":

          if(op!=null) {
            setState(() {
              switch (op) {
                case "x":

                  inputString =
                  (prevValue * double.parse(value)).toStringAsFixed(2);

                  break;
                case "+":

                  inputString =
                      (prevValue +double.parse(value)).toString();

                  break;
                case "-":

                  inputString =
                      (prevValue- double.parse(value)).toStringAsFixed(2);
                  break;
                case "/":
                  inputString =
                      (prevValue / double.parse(value)).toStringAsFixed(2);

                  break;
              }
            });
            op=null;
            prevValue=double.parse(inputString);
            value='';
            break;
          }

        break;

      default:
        if(isNumber(keyvalue)){
          if(op!=null){
            setState(() {
              inputString=inputString+keyvalue;
            });
            value=value+keyvalue;
          }else{
            setState(() {
              inputString=""+keyvalue;
            });
            op='z';
          }
        }else{
          onPressed(keyvalue);
        }

    }
  }

  @override
  Widget build(BuildContext context) {
    return MainState(
      inputValue: inputString,
      prevValue: prevValue,
      value: value,
      op: op,
      onPressed: onPressed,
      child: CalculatorLayout(),
    );
  }
}



