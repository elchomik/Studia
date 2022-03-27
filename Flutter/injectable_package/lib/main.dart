import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:injectable_package/injection.dart';
import 'package:injectable_package/presentation/counter_page.dart';
import 'package:provider/provider.dart';
import 'presentation/counter_change_notifier.dart';

void main() {
  configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (_) => getIt<CounterChangeNotifier>(),
          child: const CounterPage()),
    );
  }
}
