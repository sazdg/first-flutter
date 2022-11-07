import 'package:flutter/material.dart';


//funziona tutto perà non riesco a trovare un modo per scambiare gli indici in modo dinamico del container colorati

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '--Stack--',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'STACK WIDGET'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();


}

List <Color> colore = <Color>[Colors.orange, Colors.yellowAccent, Colors.greenAccent];


class _MyHomePageState extends State<MyHomePage> {

  Widget pnl1(){
    return Positioned(
      left: 20.0,
      child: GestureDetector(
        onTap:(){
          print("cliccato arancione");
          swapChildren(2);
        },
        child:  Container(
          width: 300,
          height: 300,
          color: colore[0],
        ),
      ),
    );
  }

  Widget pnl2(){
    return GestureDetector(
      onTap:(){
        print ("cliccato giallo");
        swapChildren(1);
      },
      child: Container(
        width: 500,
        height: 200,
        color: colore[1],
      ),
    );
  }

  Widget pnl3(){
    return Positioned(
      right: 50.0,
      top: 100.0,
      child: GestureDetector(
          onTap:(){
            print("cliccato verde");
            swapChildren(0);
          },
          child: Container(
            width: 100,
            height: 300,
            color: colore[2],
          )
      ),
    );
  }
  //List<Widget> foo = [];//<Widget>[pnl1(), pnl2(), pnl3()];
    //return <Widget>[
    //  pnl1(),
    //  pnl2(),
    //  pnl3()
    //];
  //}

  late List<Widget> foo = <Widget>[pnl3(), pnl2(), pnl1()];

  void swapChildren(int number){
    int i = 0;
    while ( i <= 2){

    }
    Widget primoElem = foo.elementAt(number); //verde

    setState((){
      foo.removeAt(number);
      foo.add(primoElem);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: foo,
    );
  }
}
