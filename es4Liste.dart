//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//#region Dichiarazione Variabili
//final List<String> entries = <String>['di pollo', 'al curry', 'con verdure'];
final List<Noodles> entries = creaNoodles();
final List<int> colorCodes = <int>[600, 400, 200, 100];
//#endregion

//#region classi
class Noodles {
  String gusto;
  double prezzo;

  Noodles(this.gusto, this.prezzo);
}

//metodo utilizzato al momento per creare un esempio di lista
//prima si crea una lista vuota
List<Noodles> creaNoodles() {
  List<Noodles> nood = [];
  nood.add(Noodles('pollo', 4.50));
  nood.add(Noodles('manzo', 4.50));
  nood.add(Noodles('verdure', 5.00));
  nood.add(Noodles('curry', 5.50));
  return nood;
}
//#endregion

void main() {
  runApp(const MyNoodlesStore());
}

class MyNoodlesStore extends StatelessWidget {
  const MyNoodlesStore({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noodles Store ',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Noodles store 4.0'),
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
  int _countBowls = 0;
  double _totPay = 0.0;
  final double _bowlCost = 2.5;
  double _noodlesCost = 0.0;

  void _incrementBowls() {
    setState(() {
      _countBowls++;
      _calcolaTot();
    });
  }

  void _incrementNoodles(double price) {
    setState(() {
      _noodlesCost += price;
      _calcolaTot();
    });
  }

  void _calcolaTot() {
    setState(() {
      _totPay = (_countBowls.toDouble() * _bowlCost) + _noodlesCost;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.amber[100],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Flexible(
                          flex: 1,
                          child: Text(
                            'How many bowls of noodles do you want?:',
                          ),
                        ),
                        Text(
                          '$_countBowls',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: 200.0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepOrange),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: 'Name for reservation',
                                hintText: 'Your name',
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Image.network(
                            'https://images.pexels.com/photos/1907228/pexels-photo-1907228.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                            width: 100,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Tooltip(
                    message: 'Add one bowl',
                    child: MaterialButton(
                      color: Colors.deepOrange,
                      onPressed: _incrementBowls,
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const <Widget>[
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Text(
                        'N.B.: If you bring back your bowl we\'ll fill it up with a second order and you\'ll get 20% discount!',
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      color: Colors.cyanAccent[index],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Noodles gusto ${entries[index].gusto} '),
                          Text('${entries[index].prezzo} £'),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                            child: Tooltip(
                              message: 'Add to basket',
                              child: ElevatedButton.icon(
                                  onPressed: () =>
                                      _incrementNoodles(entries[index].prezzo),
                                  label: const Text("Add"),
                                  icon: const Icon(
                                      Icons.shopping_basket_rounded)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Text(
                      'TOTAL $_totPay £',
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementBowls,
        tooltip: 'Add one bowl',
        child: const Icon(Icons.add),
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/home'),
        tooltip: 'Casa',
        child: const Icon(Icons.home),
      ),
    );
  }
}
