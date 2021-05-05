import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));

}


class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My first Flutter app"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body:Row(
        children: [
          Expanded(
              child: Image.asset("assets/picture.jpg"),
            flex:3,
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(30),
              color: Colors.cyan,
              child: Text("1"),
            ),
          ),
          Expanded(
            flex:4,
            child: Container(
              padding:EdgeInsets.all(30),
              color: Colors.deepOrange,
              child:Text("2"),
            ),
          ),
          Expanded(
            flex:3,
            child:
            Container(
              padding: EdgeInsets.all(30),
              color: Colors.amber,
              child: Text("3"),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[600],
        child: Text('click'),
      ),
    );
  }

}