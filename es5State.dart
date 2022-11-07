import 'package:flutter/material.dart';
import 'package:my_flutter/es1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}
class _MyHomePageState extends State<MyHomePage> {
  //QUESTO è LO STATO CON TUTTE LE VARIABILI E LE FUNZIONI
  int _counter = 0;
  String _miuascolo = "";
  //QUESTO è IL CONTROLLER PER IL TEXTFILED
  final myController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void surfing(){
    //print('hai scritto: ${myController.text}');
    setState((){
      _miuascolo = myController.text.toUpperCase();
    });
    print('hai scritto: $_miuascolo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextField(
              controller: myController,
              decoration:  const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Scrivi qualcosa',
              ),
            ),
            Spacer(),
            Tooltip(
              message: 'Magia',
              child: ElevatedButton.icon(
                onPressed: surfing,
                label: const Text (" Clicca qui"),
                icon: const Icon(Icons.surfing),
              ),
            ),
            Text(
              _miuascolo,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
