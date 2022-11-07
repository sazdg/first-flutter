//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noodles Store ',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Noodles store 2.0'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Flexible(
          flex:1,
          child: Column(
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.amber[100],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Flexible(
                        flex:1,
                        child: Text(
                          'How many bowls of noodles do you want?:',
                        ),
                      ),
                      Text(
                        '$_counter',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Flexible(
                        flex: 1,
                        child:  SizedBox(
                          width: 200.0,
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepOrange),
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              labelText: 'Name for reservation',
                              hintText: 'Your name',
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Image.network('https://images.pexels.com/photos/1907228/pexels-photo-1907228.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                          width: 100,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row (
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const <Widget> [
                Flexible (
                  flex: 4,
                  child: Padding (
                    padding: EdgeInsets.all(50.0),
                    child: Text(
                      'Price: £10.00',
                    ),
                  ),
                ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.cyanAccent[400],
                  child: const Center(
                    child: Text(
                        "Noodles di pollo"
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.cyanAccent[200],
                  child: const Center(
                    child: Text(
                        "Noodles al curry"
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.cyanAccent[100],
                  child: const Center(
                    child: Text(
                        "Noodles con verdure"
                    ),
                  ),
                ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
