import 'package:fragment_navigate/navigate-control.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(),
    );
  }
}

final String a = 'Fragment A';
final String b = 'Fragment B';
final String c = 'Fragment C';
final String d = 'Fragment D';

class Main extends StatelessWidget {
  static final FragNavigate _fragNav =
  FragNavigate(firstKey: a, drawerContext: null, screens: <Posit>[
    Posit(
        key: a,
        title: 'Pierwszy Fragment',
        icon: Icons.settings,
        fragment: Container(
          color: Colors.amberAccent,
        )),
    Posit(
        key: b,
        title: 'Drugi Fragment',
        drawerTitle: 'Drugi Fragment',
        icon: Icons.settings,
        fragment: SecondScreen()),
    Posit(
        key: c,
        title: 'Trzeci Fragment',
        icon: Icons.settings,
        fragment: Container(
          color: Colors.blueAccent,
        )),
    Posit(
        key: d, title: 'Czwarty Fragment', icon: Icons.settings, fragment: Text('Przykładowy tekst')),
  ], actionsList: [
    ActionPosit(keys: [
      a,
      b,
      c
    ], actions: [
      IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _fragNav.action('Wilkomen ');
          })
    ])
  ], bottomList: [
    BottomPosit(
        keys: [a, b, c],
        length: 2,
        child: TabBar(
          indicatorColor: Colors.white,
          tabs: <Widget>[Text('Pierwszy'), Text('Drugi')],
        ))
  ]);

  @override
  Widget build(BuildContext context) {
    _fragNav.setDrawerContext = context;

    return StreamBuilder<FullPosit>(
        stream: _fragNav.outStreamFragment,
        builder: (con, s) {
          if (s.data != null)
            return DefaultTabController(
                length: s.data!.bottom?.length ?? 1,
                child: Scaffold(
                    key: _fragNav.drawerKey,
                    appBar: AppBar(
                      title: Text(s.data!.title ?? 'NULL'),
                      actions: s.data?.actions,
                      bottom: s.data?.bottom?.child,
                    ),
                    drawer: CustomDrawer(fragNav: _fragNav),
                    body: ScreenNavigate(
                        child: s.data!.fragment, control: _fragNav)));

          return Container();
        });
  }
}

class SecondScreen extends StatelessWidget implements ActionInterface {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
    );
  }

  @override
  void action(String tag, {dynamic params}) {
    print('called on secondScreen with tag: $tag');
  }

  @override
  Future<bool> onBack() async {
    return true;
  }

  @override
  Future<bool> onPut() async {
    return true;
  }
}

class CustomDrawer extends StatelessWidget {
  final FragNavigate fragNav;
  const CustomDrawer({required this.fragNav});

  Widget _getItem(
      {required String currentSelect,
        required text,
        required key,
        required icon}) {
    Color _getColor() => currentSelect == key ? Colors.white : Colors.black87;

    return Material(
        color: currentSelect == key ? Colors.blueAccent : Colors.transparent,
        child: ListTile(
            leading:
            Icon(icon, color: currentSelect == key ? Colors.white : null),
            selected: currentSelect == key,
            title: Text(text, style: TextStyle(color: _getColor())),
            onTap: () => fragNav.putPosit(key: key)));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          for (Posit item in fragNav.screenList.values)
            _getItem(
                currentSelect: fragNav.currentKey,
                text: item.drawerTitle ?? item.title,
                key: item.key,
                icon: item.icon)
        ],
      ),
    );
  }
}