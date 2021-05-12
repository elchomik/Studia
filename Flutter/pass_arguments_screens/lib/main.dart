import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String text = 'Hello';
  String text2='World';
  Map data={};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FirstScreen'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                data['text2'],
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            SizedBox(height: 10,),
            Text(data['text1'],
            style: TextStyle(fontSize: 24.0),),
            ElevatedButton(
              onPressed: () {
                _awaitReturnValueFromSecondScreen(context);
              },
              child: Text(
                'SecondScreen',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    //start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => SecondScreen()),);

    //after the SecondScreen result comes back update the Text Widget
    setState(() {
      data = result;
    });
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  TextEditingController textFieldController=TextEditingController();
  TextEditingController textFieldController2=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.all(32.0),
          child: TextField(
            controller: textFieldController,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          ),
          SizedBox(height: 24,),
          TextField(
            controller:textFieldController2 ,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          ElevatedButton(
              onPressed:(){
                _sendDataBack(context);
              },
              child: Text(
                'Send Text Back',
                style: TextStyle(fontSize: 24),
              ),
          ),
        ],
      )
    );
  }

  void _sendDataBack(BuildContext context) {
    String textToSendBack=textFieldController.text;
    String textToSendBack2=textFieldController2.text;
    Map data={'text1':textToSendBack,'text2':textToSendBack2};
    Navigator.pop(context,data);
  }
}


