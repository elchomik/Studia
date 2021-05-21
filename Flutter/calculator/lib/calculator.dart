import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String inputString="20 +30";


  @override
  Widget build(BuildContext context) {
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
                  children: [
                    Text(
                      inputString,
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

class CalcButton extends StatelessWidget {

  final String keyvalue;
  const CalcButton({Key key, this.keyvalue}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(color: Colors.grey.shade50.withOpacity(0.85),
                style: BorderStyle.solid),
              ),
            ),
            ),
          child: Text(
            keyvalue,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
              fontStyle: FontStyle.normal,
            ),
          ),
          onPressed: (){},
          ),
        );

  }
}

