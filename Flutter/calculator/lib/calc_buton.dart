import 'package:calculator/main_state.dart';
import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {

  final String keyvalue;
  const CalcButton({Key key, this.keyvalue}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final mainState=MainState.of(context);
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
        onPressed: (){
          mainState.onPressed(keyvalue);
        },
      ),
    );

  }
}
