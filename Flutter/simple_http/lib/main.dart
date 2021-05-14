import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_http/people_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: StarWars(
      ),
    )
  );
}

class StarWars extends StatefulWidget {
  const StarWars({Key key}) : super(key: key);

  @override
  _StarWarsState createState() => _StarWarsState();
}

class _StarWarsState extends State<StarWars> {

  final String url="https://swapi.dev/api/starships";
  List data;

  Future<String> getSWData() async{
    var response= await http
        .get(Uri.parse(Uri.encodeFull(url)),headers: {"Accept":"application/json"});
  setState(() {
    var responseBody=json.decode(response.body);
    data=responseBody["results"];
  });


  return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Star Wars Starships"),
        backgroundColor: Colors.amberAccent,
      ),
      body:ListView.builder(
        itemCount: data==null ?0 :data.length,
          itemBuilder: (BuildContext context, int index){
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                 /* ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>PeopleScreen()));
                      },
                      child:Text("Open Second Screen",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                  ),*/
                  Card(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Text("Name: "),
                            Text(data[index]['name'],
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child:  Row(
                          children: [
                            Text("Model: "),
                            Text(data[index]['model'],
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      ),

                    ),
                  )
                ],
              ),

            ),

          );
          }

      ),

      persistentFooterButtons: [
        Text("People Page"),
        IconButton(
          highlightColor: Colors.blueAccent,
          icon:Icon(Icons.arrow_right),
          iconSize: 30,
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder:(context)=>PeopleScreen()));
          },
          color: Colors.amberAccent,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }
}

