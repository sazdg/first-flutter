import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './objectbox.g.dart'; // created by `flutter pub run build_runner build` in terminal
import './es11ObjectBox.dart'; // c'è la classe del DB NOSQL
import './es10ObjectBox.dart';

//dichiarata dell'istanza di classe ObjectBox chiamata objbox da me
late ObjectBox objbox;


Future<void> main() async  {
  //il momento migliore per creare il DB è nel main quando si apre l'app
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();

  //prima aspettiamo che si inizializzi l'istanza
  objbox = await ObjectBox.create();
  //lo store rimane aperto finchè c'è l'app aperta

  final box = objbox.store.box<Utente>;
  final sara = Utente("sara", "srdg");
  print(sara.informazioni());
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
  var name = "".obs;
  var password = "".obs;
  var autenticazione = false.obs;
  var messaggio = "".obs;
  var coloreMex = Colors.black.obs;
  final controllerName = TextEditingController();
  final controllerPass = TextEditingController();

  void login() {
    print('credenziali: ${controllerName.text} e ${controllerPass.text} ');
    name.value = controllerName.text.toLowerCase();
    password.value = controllerPass.text.toLowerCase();
    if (controllerName.text != "" && controllerPass.text != "") {
      autenticazione.value =
          checkAuthentication(controllerName.text, controllerPass.text);

      if (autenticazione.value) {
        name.value = controllerName.text.toLowerCase();
        messaggio.value = "Credenziali corrette";
        coloreMex.value = Colors.green;
        print('success!');
      } else {
        messaggio.value = "Credenziali SBAGLIATE";
        coloreMex.value = Colors.red;
        print('sad');
      }
    } else {
      messaggio.value = "Inserire le credenziali";
      coloreMex.value = Colors.red;
    }
  }

  bool checkAuthentication(String name, String pwd) {
    if (name.toLowerCase() == "sara" && pwd.toLowerCase() == "sara") {
      return true;
    } else {
      return false;
    }
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
