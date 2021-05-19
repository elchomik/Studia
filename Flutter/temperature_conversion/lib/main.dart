import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TempApp(),
    );
  }
}

class TempApp extends StatefulWidget {
  const TempApp({Key key}) : super(key: key);

  @override
  _TempAppState createState() => _TempAppState();
}

class _TempAppState extends State<TempApp> {

  double input;
  double output;
  bool fOrC;


  @override
  void initState() {
    super.initState();
    input=0.0;
    output=0.0;
    fOrC=true;
  }

  @override
  Widget build(BuildContext context) {
    TextField inputField= TextField(
      keyboardType: TextInputType.number,
      onChanged: (str){
        try{
          input=double.parse(str);
        }catch(e){
          input=0.0;
        }
      },
      decoration: InputDecoration(
        labelText: "Input value in ${fOrC==false ? "Fahrenheit" : "Celsius"}",
      ),
    );

    AppBar appBar=AppBar(
      title: Text("Temperature Calculator"),
    );

    Container tempSwitch=Container(
      child: Row(
        children: [
          Text("Choose Fahrenheit or Celsius"),
          SizedBox(width: 8,),
          /*Switch(
              value: fOrC,
              onChanged: (e){
                setState(() {
                  fOrC = !fOrC;
                });
              }),

           */
         /* Checkbox(
            value: fOrC,
            onChanged: (e){
              setState(() {
                fOrC=!fOrC;
              });
            },
          )
          */
          Text("F"),
          Radio(
              value:false,
              groupValue: fOrC,
              onChanged: (e){
                setState(() {
                  fOrC=e;
                });
              }),
          Text("C"),
          Radio(
              value: true,
              groupValue: fOrC,
              onChanged: (e){
                setState(() {
                  fOrC=e;
                });
              })
        ],
      ),
    );

    Container calculateBtn=Container(
      child: ElevatedButton(
        child: Text("Calculate"),
        onPressed: (){
          setState(() {
            fOrC==false ? output=(input-32)*(5/9)
                :output=(input*9/5)+32;
          });
          
          AlertDialog dialog=AlertDialog(
            content: fOrC==false ?
                Text("${input.toStringAsFixed(2)} F : ${output.toStringAsFixed(2)} C")
                :Text("${input.toStringAsFixed(2)} C : ${output.toStringAsFixed(2)} F"),
          );


          showDialog(context: context, builder:(context)=>dialog);
        },
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            inputField,
            tempSwitch,
            calculateBtn

          ],
        )
      ),
    );
  }
}

