// ignore_for_file: control_flow_in_finally

import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

void main()   {

  runApp(Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: PaginaLogin(),
    );
  }
}

class PaginaLoginController extends GetxController {
  //TIENE IL CONTO SOLO DELLE VARIABILI E DELLE FUNZIONI

  var name = "".obs; //prova
  var password = "".obs;
  var autenticazione = false.obs;
  var messaggio = "".obs;
  var coloreMex = Colors.black.obs;
  final controllerName = TextEditingController();
  final controllerPass = TextEditingController();

  void login() async {
    print('credenziali: ${controllerName.text} e ${controllerPass.text} ');
    name.value = controllerName.text.toLowerCase();
    password.value = controllerPass.text.toLowerCase();
    if (controllerName.text != "" && controllerPass.text != "") {
      autenticazione.value = await checkAuthenticationDaExcel(controllerName.text, controllerPass.text);

      if (autenticazione.value) {
        name.value = controllerName.text.toLowerCase();
        messaggio.value = "Credenziali corrette";
        coloreMex.value = Colors.green;
        print('success!');
      } else {
        messaggio.value = "Credenziali SBAGLIATE";
        coloreMex.value = Colors.red;
        print('credenziali sbagliate sorry');
      }
    } else {
      messaggio.value = "Inserire le credenziali";
      coloreMex.value = Colors.red;
    }
  }

  Future<bool> checkAuthenticationDaExcel(String name, String pwd) async {
    bool accesso = false;
    try {
      //FILE XLSX DA GOOGLE DRIVE
      var url = Uri.parse('https://docs.google.com/spreadsheets/d/1QJdUitURtJSyVYIrqrRm7ZkN5JhGKCOFqxeW2FGroW8/edit?usp=share_link');
      var response = await http.get(url);

      if (response.statusCode == 200){
        List<String> credenziali = estrapolaDati(response.body);
        //credenziali[0] sarebbe "credenzialiUtente"
        //controllare che ci siano i dati
        if (credenziali.isNotEmpty){
          if (name == credenziali[1] && pwd == credenziali[2]) {
            accesso = true;
          }
        } else {
          print("Non ci sono dati");
        }

      } else {
        print("Request failed with status: ${response.statusCode}");
      }

    } catch(e) {
      print(e);
      return accesso;
    } finally {
      return accesso;
    }


  }

  List<String> estrapolaDati(String bodyPagina){
    List<String> stringaCredenziali = [];
    try {
      int inizio = bodyPagina.indexOf("credenzialiUtente");
      int fine = bodyPagina.indexOf("stopCredenzialiUtente");
      stringaCredenziali = bodyPagina.substring(inizio, fine).toLowerCase().split(",");
      print ("utente ${stringaCredenziali[1]} e password ${stringaCredenziali[2]}");

    } catch (e){
      print("errore nella lettura della pagina");

    } finally {
      return stringaCredenziali;
    }

  }
  bool checkAuthenticationDaJson(String name, String pwd){
    return false;
  }
}

class PaginaLogin extends StatelessWidget {
//class PaginaLogin extends GetView<PaginaLoginController> {
//getView penso sia per la route
  PaginaLogin({super.key});

  //CREA UN'ISTANZA DI CONTROLLER e tiene conservato in memoria tutte le var da usare
  //LA PRIMA VOLTA SI USA GET
  //LE ALTRE VOLTE SI PUò USARE FIND PERCHè ORMAI ESISTE GIà UN'ISTANZA
  final controller = Get.put(PaginaLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN PAGE'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100.0),
              child: Column(
                children: <Widget>[
                  const Text("Name"),
                  TextField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    controller: controller.controllerName,
                  ),
                  const Text("Password"),
                  TextField(
                    autofocus: false,
                    textAlign: TextAlign.center,
                    controller: controller.controllerPass,
                  ),
              ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                color: Colors.purple,
                onPressed: () => controller.login(),
                child: const Text(
                  "LOG IN",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Obx(() => Text(
              controller.messaggio.string,
              style: TextStyle(
                color: controller.coloreMex.value,
              ),
            ),
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/home'),
        tooltip: 'Casa',
        child: const Icon(Icons.home),
      ),
    );
  }
}
