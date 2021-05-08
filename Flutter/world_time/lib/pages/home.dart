import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              // ignore: deprecated_member_use
              TextButton.icon(
                  onPressed: (){
                    Navigator.pushNamed(context,'/location');
                  },
                  icon:Icon(Icons.edit_location),
                  label:Text("edit location"),
                style: TextButton.styleFrom(
                  primary: Colors.grey[850],
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}

