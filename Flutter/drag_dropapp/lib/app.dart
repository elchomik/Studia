import 'package:drag_dropapp/DragBox.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  Color caughtColor=Colors.grey;
  String text='Drag Here';
  String text1='Box One';
  String text2='Box Two';
  String text3='Box Three';
  String text4='Box Four';
  String text5='Box Five';
  String text6='Box Six';
  DragBox box1=new DragBox(Offset(0.0,0.0),'Box One',Colors.blueAccent);
  DragBox box2= new DragBox(Offset(100.0,0.0),'Box Two',Colors.orange);
  DragBox box3= new DragBox(Offset(200.0,0.0),'Box Three',Colors.lightGreen);
  DragBox box4=new DragBox(Offset(0.0,100.0),'Box Four',Colors.greenAccent);
  DragBox box5= new DragBox(Offset(100.0,100.0),'Box Five',Colors.red);
  DragBox box6= new DragBox(Offset(200.0,100.0),'Box Six',Colors.brown);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:40,left: 20.0),
      child: Stack(
        children: [
            box1,
            box2,
            box3,
            box4,
            box5,
            box6,
          Positioned(
             left: 100.0,
             bottom: 0.0,
              child: DragTarget(
                onAccept: (Color color){
                  caughtColor=color;
                  setState(() {
                    if(box1.label==text1 && caughtColor==Colors.blueAccent) text=text1;
                    if(box2.label==text2 && caughtColor==Colors.orange) text=text2;
                    if(box3.label==text3 && caughtColor==Colors.lightGreen) text=text3;
                    if(box4.label==text4 && caughtColor==Colors.greenAccent) text=text4;
                    if(box5.label==text5 && caughtColor==Colors.red) text=text5;
                    if(box6.label==text6 && caughtColor==Colors.brown) text=text6;
                  });
        },
                builder:(
                BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                ){
                  return Container(
                  width:200.0,
                  height: 200.0,
              decoration:BoxDecoration(
                color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
              ),
                  child:Center(
                   child:Text(
                     accepted.isEmpty ? text : 'Drag Here',
                   ),
              ),
                  );
              },
              ),
          ),
        ],
      ),
    );
  }


}
