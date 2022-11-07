import 'objectbox.g.dart';
import 'es10ObjectBox.dart'; // per le classi Utente e Note

class ObjectBox {
  //attributo store di tipo store (del pacchetto object box)
  late final Store store;

  //costruttore penso
  ObjectBox._create(this.store){
    //query ?
  }

  //creazione di istanza della classe
  static Future<ObjectBox> create() async {
    //openStore dipende dal file objectbox.g.dart
    final mystore = await openStore();
    return ObjectBox ._create(mystore);
  }

}