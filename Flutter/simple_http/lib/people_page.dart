import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key key}) : super(key: key);

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {

  final String url="http://swapi.dev/api/people";
  List peopleData;

  Future<String> getPeopleDataSW() async{

    var response=await http
    .get(Uri.parse(Uri.encodeFull(url)),headers: {"Accept":"application/json"});

    setState(() {
      var responseBody=json.decode(response.body);
      peopleData=responseBody['results'];
    });

    return "Succes";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Star Wars - People"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: peopleData==null ? 0: peopleData.length,
          itemBuilder: (BuildContext context,int index){
              return Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Card(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Text("Name: "),
                                Text(peopleData[index]['name'],
                                style: TextStyle(
                                  fontSize: 18.0,
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
                            child: Row(
                              children: [
                                Text("Height: "),
                                Text(peopleData[index]['height'],
                                style: TextStyle(
                                fontSize: 18.0
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
                            child: Row(
                              children: [
                                Text("Birth Year: "),
                                Text(peopleData[index]['birth_year'],
                                style: TextStyle(
                                  fontSize: 18.0,
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
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getPeopleDataSW();
  }
}
