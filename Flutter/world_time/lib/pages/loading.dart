import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  Future<void> setupWorldTime() async {
    WorldTime worldTime=WorldTime(location: 'London',flag: 'UK.png',url: 'Europe/London');
    await worldTime.getTime();
    Navigator.pushReplacementNamed(context, '/home',arguments: {
     'location': worldTime.location,
      'flag':worldTime.flag,
     'time':worldTime.time,
      'isDayLine': worldTime.isDayLine,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body:Center(
         child: SpinKitHourGlass(
           color: Colors.white,
           size: 80.0,
          ),
      ),
    );
  }
}
