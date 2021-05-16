import 'package:flutter/material.dart';
import 'package:grid_view/SimpleWidget.dart';
import 'package:grid_view/TheGridView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{
  TabController tabController;


  @override
  void initState() {
    super.initState();
    tabController=TabController(length: 2, vsync: this);
  }


  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  TabBar makeTabBar(){
    return TabBar(
      tabs: [
        Tab(icon: Icon(Icons.home)),
        Tab(icon: Icon(Icons.settings_power)),
      ],controller: tabController
    );
  }

  TabBarView makeTabBarView(tabs){
    return TabBarView(
        children: tabs,
      controller: tabController,
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          bottom: makeTabBar(),
        ),
        body: makeTabBarView([
          TheGridView().build(),
          SimpleWidget()
        ]),
      ),
    );
  }
}





