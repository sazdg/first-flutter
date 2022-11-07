import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Person {
  Person({required this.name, required this.age, required this.friends});

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  List<String> friends;

  @override
  String toString(){
    return 'nome: $name ed età $age';
  }
}

void main() async {

  var box = await Hive.openBox('testBox');

  var person = Person(
    name: 'Sara',
    age: 22,
    friends: ['Giacomo', 'Martina', 'Carola'],
  );

  await box.put('sara', person);
  print(box.get('sara'));
  print(person.toString());

}





