import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter/es4Liste.dart';
import 'package:my_flutter/es9Login.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends GetMaterialApp {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //GetMaterialApp è del package get
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Routing',
      initialRoute: '/home', //LA PRIMA PAGINA SARà LA HOME OVVERO RIPORTA CLASSE CASA
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      //home: const MyHomePage(title: 'ROUTING PAGE'), //QUELLA GIà IMPOSTATA
      //home: Casa(), //QUELLA CHE HO CREATO IO
      getPages: funzioneDinamicaDiGetPagesPerRouting(), //QUELLA FATTA CON GETPAGES
    );
  }
}

funzioneDinamicaDiGetPagesPerRouting() => [
  GetPage(
    name: '/home',
    page: () => Casa(),
    transition: Transition.noTransition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/foo',
    page: () => Foo(),
    transition: Transition.noTransition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/noodles',
    page:  () => MyNoodlesStore(),
    transition: Transition. noTransition,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/login',
    page: () => PaginaLogin(),
    transition: Transition.noTransition,
    transitionDuration: const Duration(milliseconds: 500),
  )
];

class Casa extends StatelessWidget {
  //CLASSE SENZA STATO PERCHè SE NE OCCUPA GETX
  var testoPagina = 'Hello GetPages'.obs;


  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('CASA - Routing page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            const Spacer(),
            Text(testoPagina.value), //PER ACCEDERE ALLE VARIABILI USARE LA FUNZIONE .VALUE
            const Spacer(),
            MaterialButton(
              color: Colors.blue,
                //GO TO NAMED PER PASSARE EVENTUALI PARAMETRI è COMODO
              onPressed: () => Get.toNamed('/foo', arguments: {'fraseDaPassare':'lista de cosas que hacer'}),//Get.off(() => Foo()),
              child: const Text('FOO'),
            ),
            const Spacer(),
            MaterialButton(
              color: Colors.amber,
              onPressed: () => Get.toNamed('/noodles'),
              child: const Text('NOODLES STORE'),
            ),
            const Spacer(),
            MaterialButton(
              color: Colors.purple,
              onPressed: () => Get.toNamed('/login'),
              child: const Text("LOGIN"),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class Foo extends StatelessWidget {
  //CLASSE SENZA STATO PERCHè SE NE OCCUPA GETX
  var testoPagina = 'Hello Foo'.obs;

  //PER RINTRACCIARE GLI ARGOMENTI PASSATI
  Map argumentData = Get.arguments?? Map();


  //leggere un file json
  //Future<List<String>>
  void fetchLista() async {
    var link = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    final response = await http.get(link);
    if (response.statusCode == 200){
      print(response.body);
    } else {
      print("nothing");
    }
    //List<String> listaToDo = [];
    //return listaToDo;
  }

  Widget build(BuildContext context){
    //print('argomenti = $argumentData');
    return Scaffold(
      appBar: AppBar(
        title: Text('Foo - Routing page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            const Spacer(),
            Text('${argumentData["fraseDaPassare"]}'), //PER LEGGERE I DATI PASSATI COME ARGOMENTO
            const Spacer(),
            MaterialButton(
              color: Colors.pinkAccent,
              onPressed: fetchLista,
              child: const Text(
                "Click para ver las cosas pro hacer"
              )
            ),
            const Spacer(),
            FutureBuilder<String>(
              future: futureToDo,
              builder: (context, snapshot){
                if (snapshot.hasData){
                  return Text(snapshot.data!.title);
                } else if (snapshot.hasError){
                  return Text('${snapshort.error}');
                }
                return const CircularProgressIndicator();
              }
            )
            const Spacer(),
            Tooltip(
              message: 'Casa',
              child: FloatingActionButton(
                  onPressed: () => Get.toNamed('/home'),
                  tooltip: 'Casa',
                  child: const Icon(Icons.home),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}