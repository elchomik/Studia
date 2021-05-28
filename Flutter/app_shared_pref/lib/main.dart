import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title:Text("Shared Preferences"),
        ),
        body: Home(),
      ),
    );
  }

}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

Future<SharedPreferences> _sharedPreferences=SharedPreferences.getInstance();
final TextEditingController controller=TextEditingController();
List<String> inputList,outputList;


@override
  void initState() {
    super.initState();
    inputList=[];
    outputList=[];
  }

  Future<Null> addString() async {
    final SharedPreferences prefs = await _sharedPreferences;
    inputList.add(controller.text);
    prefs.setStringList('list', inputList);
    setState(() {
      controller.text = '';
    });
  }

  Future<Null> clearItems() async{
    final SharedPreferences pref= await _sharedPreferences;
    pref.clear();
    setState(() {
      inputList=[];
      outputList=[];
    });
  }

  Future<Null> getStrings() async{
    final SharedPreferences prefs=await _sharedPreferences;
    outputList=prefs.getStringList('list');
    setState(() {});
  }

  Future<Null> updateStrings(String str) async{
    final SharedPreferences prefs=await _sharedPreferences;
    setState(() {
      inputList.remove(str);
      outputList.remove(str);
    });
    prefs.setStringList('list',inputList);
  }





  @override
  Widget build(BuildContext context) {
  getStrings();
    return Center(
      child: ListView(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Wpisz coś ...",
            ),
          ),
          ElevatedButton(
              onPressed: addString,
              child: Text("Potwierdź")),
          ElevatedButton(
              onPressed: clearItems,
              child: Text("Wyczyść")),
          Flex(
              direction: Axis.vertical,
          children:
            outputList==null ? [] : outputList
              .map((String item) =>Dismissible(
                  key: Key(item),
                  onDismissed: (direction){
                    updateStrings(item);
                    },
                  child: ListTile(
                  title: Text(item),
                  )))
            .toList(),


          ),
          

        ],
      ),
    );
  }
}




