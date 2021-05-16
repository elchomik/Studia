import 'package:flutter/material.dart';

class TheGridView{
  Card makeGridCell(String name,IconData icon){

    return Card(
      elevation: 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: [
          Center(child: Icon(icon)),
          Center(child: Text(name)),
        ],
      ),
    );
  }

  GridView build(){
    return GridView.count(
      primary: true,
        padding: EdgeInsets.all(1.0),
        crossAxisSpacing: 1.0,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.0,
        crossAxisCount:2,
      children: [
        makeGridCell("Home",Icons.home),
        makeGridCell("Email",Icons.email),
        makeGridCell("Chat",Icons.chat),
        makeGridCell("News",Icons.new_releases),
        makeGridCell("Network",Icons.network_wifi),
        makeGridCell("Options",Icons.settings)
      ],
    );
  }
}