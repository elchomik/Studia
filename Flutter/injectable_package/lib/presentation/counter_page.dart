import 'package:flutter/material.dart';
import 'package:injectable_package/presentation/counter_change_notifier.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Injectable Counter App'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times: '),
            Consumer<CounterChangeNotifier>(builder: (context, counter, child) {
              return Text(
                '${counter.value}',
                style: Theme.of(context).textTheme.headline4,
              );
            })
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: Provider.of<CounterChangeNotifier>(context).increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ));
  }
}
