import 'package:calculator/main_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'calc_buton.dart';


class CalculatorLayout extends StatelessWidget {
  const CalculatorLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainState=MainState.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color:Colors.blueGrey.withOpacity(0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    mainState.inputValue ?? '0',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontSize: 48.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                children: [
                  makeButtons('C%</'),
                  makeButtons('789x'),
                  makeButtons('456-'),
                  makeButtons('123+'),
                  makeButtons('_0.='),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeButtons(String row){
    List<String> token=row.split("");
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: token.map((e)=>CalcButton(
          keyvalue: e =='_' ? "+/-": e == '<' ? '<=':e,
        )).toList(),

      ),
    );
  }
}
