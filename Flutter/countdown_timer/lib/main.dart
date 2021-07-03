import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

void main(){
  runApp(MaterialApp(
    home: App()
  ));
}

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {

  AnimationController controller;
  TextEditingController userInputController=TextEditingController();
  TextEditingController aktualnuCzasController=TextEditingController();

  String get timerString{
    Duration duration=controller.duration*controller.value;
    return"${duration.inMinutes}:${(duration.inSeconds%60).toString().padLeft(2,'0')}";

  }


  int durationTimer=30;


  @override
  void initState() {
    super.initState();
    aktualnuCzasController.text='30';
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData=Theme.of(context);
    controller=AnimationController(
        vsync: this,
        duration: Duration(seconds: durationTimer));

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Align(
                  alignment: FractionalOffset.center,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (BuildContext context, Widget child){
                                return CustomPaint(
                                  painter: TimerPainter(
                                    animation: controller,
                                    backgroundColor: Colors.white,
                                    color: themeData.indicatorColor
                                  ));
                              },
                            ),
                        ),
                        Align(
                          alignment: FractionalOffset.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Odliczanie",
                              style: themeData.textTheme.subtitle1,),
                              AnimatedBuilder(
                                  animation: controller,
                                  builder:(context,child){
                                    return Text(
                                      timerString,
                                      style: themeData.textTheme.headline4,
                                    );
                                  }),

                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                )),
            Column(
              children:[
                  Row(
                    children:[
                      Text("Podaj nowy czas"),
                      SizedBox(width: 20,),
                      Container(
                      width: 80,
                      height: 30,
                      child: TextField(
                    decoration: InputDecoration(
                      hintText: "Podaj czas",
                    ),
                    controller: userInputController,
                    onSubmitted: (value){
                      setState(() {
                        try{
                          durationTimer=int.parse(value);
                          controller.value=durationTimer.toDouble();
                          aktualnuCzasController.text=durationTimer.toString();
                          userInputController.text='';
                        }on FormatException{
                          durationTimer=30;
                        }
                      });
                    },
                    autofocus: true,
                    showCursor: true,
                  ),
                ),
                  SizedBox(width: 20,),
                  ElevatedButton(
                      onPressed: (){
                        setState(() {
                          controller.value=30;
                          userInputController.text='';
                          aktualnuCzasController.text='30';
                        });
                      },
                      child: Text("Reset")),
              ],
              ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text("Aktualny czas"),
                    SizedBox(width: 20,),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Aktualny czas',
                        ),
                        controller: aktualnuCzasController,
                        enabled: false,
                      ),
                    )
                  ],
                )
            ]
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  FloatingActionButton(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (context,child){
                        return Icon(
                            controller.isAnimating
                                ? Icons.pause
                                :Icons.play_arrow);
                      },
                    ),
                      onPressed:(){
                      if(controller.isAnimating)
                        controller.stop(canceled: true);
                     else controller.reverse(
                        from: controller.value==0.0
                            ?1.0
                            :controller.value
                      );
                      })
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter{
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color
}):super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor,color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint=Paint()
        ..color=backgroundColor
        ..strokeWidth=5.0
        ..strokeCap=StrokeCap.round
        ..style=PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero),size.width/2.0, paint);
    paint.color=color;
    double progress=(1.0-animation.value)*2*math.pi;
    canvas.drawArc(Offset.zero&size,math.pi*1.5,
        -progress,false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) {
    return animation.value!=oldDelegate.animation.value ||
    color!=oldDelegate.color || backgroundColor!=oldDelegate.backgroundColor;
  }
}


