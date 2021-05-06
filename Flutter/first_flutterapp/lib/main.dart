import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Card(),
  ));
}
class Card extends StatefulWidget {
  const Card({Key key}) : super(key: key);

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> {

  int level=0;
  String text="BEGINNER";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
      title: Text("Basic Card"),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
    ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0,40.0,30.0 ,0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: CircleAvatar(
                backgroundImage:NetworkImage("https://graph.facebook.com/1463985430423977/picture?type=large"),
                radius: 40.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.grey[800],
            ),
            Text(
              'NAME',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Mateusz',
            style: TextStyle(
              color: Colors.amberAccent[200],
              letterSpacing: 2.0,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(height:30.0),
            Row(
              children:[
                    Text(
                      'LEVEL',
                      style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
              ),
            ),
            SizedBox(width: 20.0),
                Text(
                  "$text",
                  style: TextStyle(
                    color: Colors.green,
                    letterSpacing: 2.0,
                  ),
                ),
            ],),
            Text(
              '$level',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 10.0),
                Text(
                  'mateusz@gmail.com',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18.0,
                    letterSpacing:1.0,
                  ),
                ),


          ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Colors.grey[800],
                    onPressed: (){
                      setState(() {
                        level++;
                        if(level>0 && level<20) text="BEGINNER";
                        if(level>20 && level<40) text="JUNIOR";
                        if(level>40 && level<80) text="REGULAR";
                        if(level>80)  text="SENIOR";

                      });
                    }),
                SizedBox(width: 10,),
                FloatingActionButton(
                  child: Icon(Icons.remove),
                    backgroundColor: Colors.grey[800],
                    onPressed: (){
                    setState(() {
                      level--;
                      if(level>0 && level<20) text="BEGINNER";
                      if(level>20 && level<40) text="JUNIOR";
                      if(level>40 && level<80) text="REGULAR";
                      if(level>80)  text="SENIOR";
                      if(level==0) level=0;
                     
                    });
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}





