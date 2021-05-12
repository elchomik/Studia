

import 'package:flutter/material.dart';
import 'form_screen.dart';
class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

   Map data={};



  @override
  Widget build(BuildContext context) {

    data=ModalRoute.of(context).settings.arguments;
    print(data);

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Container(
        child: Column(
          children:[ Padding(
            padding:EdgeInsets.fromLTRB(24,200,30,16),
                child: ElevatedButton(
                    onPressed:() async {

                      Navigator.pushNamed(context,'/form');
                    },
                    child: Text(
                        "Utwórz Formularz",
                    style:TextStyle(
                      fontSize:26,
                      color: Colors.black,
                      backgroundColor: Colors.white,
                    )),
                ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children:[
              Text("Name",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
              ),
                  Text("Text"),
              ],
              ),
            ),
          ],
          ),
        ),
      ),
      );
  }
}
