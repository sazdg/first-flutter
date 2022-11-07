import 'package:objectbox/objectbox.dart';

@Entity()
class Note{
  int id = 0;
  String? testo;
  @Property(type: PropertyType.date)
  DateTime dataora = DateTime.now();

  //costruttore
  Note({this.testo, DateTime? date}) : dataora = date ?? DateTime.now();

  //per i log
  toString() => 'Note{id: $id, testo: $testo, dataora: $dataora}';
}

@Entity()
class Utente{
  int id = 1;
  String nome = "";
  String password = "";
  @Property(type: PropertyType.date)
  DateTime creazione = DateTime.now();

  Utente(this.nome, this.password) {
    creazione = DateTime.now();
  }
  //per i log
  informazioni() => 'Utente: $nome (password: $password), ultimo accesso: $creazione';
}

