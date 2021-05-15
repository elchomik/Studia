import 'package:dynamic_lists_streams/photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class PhotoList extends StatefulWidget {
  const PhotoList({Key key}) : super(key: key);

  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {

  StreamController<Photo> streamController;
  List<Photo> photList=[];


  @override
  void initState() {
    super.initState();
    streamController=StreamController.broadcast();

    streamController.stream.listen((p)=>setState(()=>photList.add(p)));
    load(streamController);
  }

  load(StreamController<Photo> sc) async{
    String url="https://jsonplaceholder.typicode.com/photos";
    var client=new http.Client();
    var request=new http.Request('get',Uri.parse(url));
    var streamResponse=await client.send(request);
    
    streamResponse.stream
    .transform(utf8.decoder)
    .transform(json.decoder)
    .expand((element) => element)
    .map((photoMap) =>Photo.fromJsonMap(photoMap))
    .pipe(sc);

  }


  @override
  void dispose() {
    super.dispose();
    streamController?.close();
    streamController=null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Streams"),
      ),
      body:Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
            itemBuilder:(BuildContext context,int index)=>_makeElement(index),
        ),
      ) ,
    );
  }

 Widget _makeElement(int index) {
    if(index>=photList.length) return null;

    return Container(
      padding: EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.only(top:200.0),
        child: Column(
          children: [
            Image.network(photList[index].url,width: 150.0,height: 150.0,),
            Text(photList[index].title),
          ],
        ),
      ),
    );
 }
}
