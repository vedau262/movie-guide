import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Person extends HiveObject {

  @HiveField(0)
  String? name;

  @HiveField(1)
  int? age;

  @HiveField(2)
  List<String>? friends;

  @override
  String toString() {
    return '$name: $age';
  }

  Person({this.name, this.age, this.friends});
}
