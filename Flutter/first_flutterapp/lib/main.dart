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
  int imageCounter=0;
  String text="BEGINNER";
  String name="Mateusz";
  String email="mateusz@gmail.com";
  String title="Profile 1";
  NetworkImage image=NetworkImage("https://graph.facebook.com/1463985430423977/picture?type=large");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[900],
      appBar: AppBar(
      title: Text("$title"),
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
               backgroundImage:image,
                radius: 100.0,
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
              '$name',
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
                  '$email',
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
                      if(level<0) level=0;
                     
                    });
                    }),
                SizedBox(width: 10),
                FloatingActionButton(
                    child: Icon(Icons.sensor_door),
                    backgroundColor: Colors.grey[800],
                    onPressed: (){
                      setState(() {
                        level=0;
                        image=NetworkImage("https://graph.facebook.com/1463985430423977/picture?type=large");
                        imageCounter=0;
                        title="Profil 1";
                        email="mateusz@gmail.com";
                        name="Mateusz";

                      });
                    }),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  child: Icon(Icons.arrow_left),
                    backgroundColor: Colors.grey[800],
                    onPressed: (){
                    setState(() {
                      imageCounter--;
                      if(imageCounter%5==0) {
                        image = NetworkImage("https://graph.facebook.com/1463985430423977/picture?type=large");
                        name="Mateusz";
                        email="mateusz@gmail.com";
                        title="Profile 1";
                      }
                        if(imageCounter%5==1) {
                          image=NetworkImage("https://images.unsplash.com/photo-1572436289404-e7cb53272e7a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80");
                          name="Sydney";
                          email="sydney@gmail.com";
                          title="Profile 2";
                        }
                          if(imageCounter%5==2) {
                            image=NetworkImage("https://images.unsplash.com/photo-1507503343980-19961fa0ca17?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDF8NnNNVmpUTFNrZVF8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
                            name="Ptak";
                            email="ranny@ptaszek.pl";
                            title="Profile 3";
                          }
                      if(imageCounter%5==3) {
                        image = NetworkImage("https://images.unsplash.com/photo-1620097064445-1a64d19ff2f5?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDE0fEZ6bzN6dU9ITjZ3fHxlbnwwfHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
                        name="Nocne Niebo";
                        email="nocne@niebo.pl";
                        title="Profile 4";
                      }
                        if(imageCounter%5==4) {
                          image=NetworkImage("https://images.unsplash.com/photo-1504311640015-772816fba558?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDEzfEZ6bzN6dU9ITjZ3fHxlbnwwfHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
                          name="Zorza Polarna";
                          email="zorza.polarna@wp.pl";
                          title="Profile 5";
                        }

                    });
                    }),
                SizedBox(width: 10),
                FloatingActionButton(
                  child:Icon(Icons.arrow_right),
                    backgroundColor: Colors.grey[800],
                    onPressed: (){
                    setState(() {
                      imageCounter++;
                      if(imageCounter%5==0) {
                        image=NetworkImage("https://graph.facebook.com/1463985430423977/picture?type=large");
                        name="Mateusz";
                        email="mateusz@gmail.com";
                        title="Profile 1";

                      }
                      if(imageCounter%5==1) {
                        image = NetworkImage("https://images.unsplash.com/photo-1572436289404-e7cb53272e7a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80");
                        name="Sydney";
                        email="sydney@gmail.com";
                        title="Profile 2";
                      }
                      if(imageCounter%5==2) {
                        image = NetworkImage("https://images.unsplash.com/photo-1507503343980-19961fa0ca17?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDF8NnNNVmpUTFNrZVF8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
                        name="Ptak";
                        email="ranny@ptaszek.pl";
                        title="Profile 3";
                      }
                      if(imageCounter%5==3) {
                        image = NetworkImage("https://images.unsplash.com/photo-1620097064445-1a64d19ff2f5?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDE0fEZ6bzN6dU9ITjZ3fHxlbnwwfHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
                        name="Nocne Niebo";
                        email="nocne@niebo.pl";
                        title="Profile 4";
                      }
                        if(imageCounter%5==4) {
                          image=NetworkImage("https://images.unsplash.com/photo-1504311640015-772816fba558?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDEzfEZ6bzN6dU9ITjZ3fHxlbnwwfHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");
                          name="Zorza Polarna";
                          email="zorza.polarna@wp.pl";
                          title="Profile 5";

                        }
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





