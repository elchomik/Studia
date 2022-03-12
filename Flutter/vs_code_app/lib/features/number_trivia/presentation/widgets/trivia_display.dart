import 'package:flutter/cupertino.dart';
import 'package:vs_code_app/features/number_trivia/domain/entities/number_trivia.dart';

class TriviaDisplay extends StatelessWidget {
  const TriviaDisplay({Key? key,required this.numberTrivia}) : super(key: key);

  final NumberTrivia numberTrivia;

  @override
  Widget build(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height/3,
      child: Column(
        children: [
          Text(
            numberTrivia.number.toString(),
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  numberTrivia.text,
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}