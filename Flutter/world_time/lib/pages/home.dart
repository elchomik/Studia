import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data={};

  @override
  Widget build(BuildContext context) {

    data=data.isNotEmpty ? data :ModalRoute.of(context).settings.arguments;
    print(data);

    //set background
    if(null==data['isDayLine']) data['isDayLine']=true;
    String bgImage=data['isDayLine'] ? 'day.png' : 'night.png';
    Color bgColor=data['isDayLine'] ? Colors.blue : Colors.indigo[700];
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/$bgImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120,0,0),
              child: Column(
                children: [
                  // ignore: deprecated_member_use
                  TextButton.icon(
                      onPressed: () async {
                        dynamic result= await Navigator.pushNamed(context,'/location');
                        setState(() {
                          data={
                            'time':result['time'],
                            'location':result['location'],
                            'isDayLine':result['isDayLine'],
                            'flag':result['flag'],
                          };
                        });
                        },
                      icon:Icon(
                          Icons.edit_location,
                          color: Colors.grey[300],
                      ),
                      label:Text(
                          "edit location",
                        style: TextStyle(
                          color: Colors.grey[300],
                        ),
                      ),
                    style: TextButton.styleFrom(
                      primary: Colors.grey[850],
                      textStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66.0,
                      color: Colors.white,
                    ),
                  ),

                ],
              ),
            ),
          ),
      ),
    );
  }
}

