import 'package:flutter/material.dart';

import 'display_form.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final name=TextEditingController();
  final phoneNumber=TextEditingController();
  final email=TextEditingController();

  List<DisplayForm> users=[];

  void getItemAndNavigate(BuildContext context){
    users.add(DisplayForm(nameHolder: name.text,numberHolder: phoneNumber.text,emailHolder: email.text,));
    print(name.text);
    print(phoneNumber.text);
    print(email.text);
    print(users.length);
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>DisplayForm(
          nameHolder: name.text,
          numberHolder:phoneNumber.text,
          emailHolder: email.text,
          users:users,
        )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: name,
                autocorrect: true,
                decoration: InputDecoration(hintText: 'Wpisz imię'),
              ),
            ),
            Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: email,
                autocorrect: true,
                decoration: InputDecoration(hintText: 'Podaj email'),
              ),
            ),
            Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: phoneNumber,
                autocorrect: true,
                decoration: InputDecoration(hintText: 'Podaj numer telefonu'),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                getItemAndNavigate(context);
              },
              child: Text('Dodaj użytkownika',
                style: TextStyle(
                  color: Colors.teal,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}