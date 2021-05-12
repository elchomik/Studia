import 'package:flutter/material.dart';


// ignore: must_be_immutable
class  DisplayForm extends StatelessWidget {
  final nameHolder;
  final numberHolder;
  final emailHolder;
  List<DisplayForm> users=[];
  DisplayForm({Key key, this.nameHolder, this.numberHolder, this.emailHolder, this.users}) : super(key: key);

  goBack(BuildContext context){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dane z formularza"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Imie ='+ nameHolder,
              style: TextStyle(
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15,),
          Center(
            child: Text('Email ='+ emailHolder,
              style: TextStyle(
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15,),
          Center(
            child: Text('Telefon ='+ numberHolder,
              style: TextStyle(
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15.0,),
          Text("Ilość użytkowników ${users.length}",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}