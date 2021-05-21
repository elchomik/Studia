import 'package:flutter/material.dart';

class DisplayPage extends StatelessWidget {
   DisplayPage({Key key}) : super(key: key);

  final List<String> images=[
    'assets/wallpaper-1.jpeg',
    'assets/wallpaper-2.jpeg',
    'assets/wallpaper-3.jpeg'
  ];
  final List<String> descriptions=[
    'Mapa',
    'Żarowka',
    'Dom'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: Size.fromHeight(550.0),
          child: PageView.builder(
            controller: PageController(viewportFraction: 1.0),
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index){
              return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0
                  ),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                     Image.asset(
                        images[index],
                        fit:BoxFit.cover
                      ),
                      DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.topCenter,
                              colors: [
                                Color(0x00000000).withOpacity(0.9),
                                Color(0xff000000).withOpacity(0.01),
                              ],
                            )
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(descriptions[index],
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 2.0,
                          color: Colors.amber
                        ),
                        ),
                      ),

                    ],
                  ),
                ),
              );
              }
          ),
        ),
      ),
    );
  }
}
