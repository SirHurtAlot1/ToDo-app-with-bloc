/*
  ISAR TO DO MODEL

  converts todo model into isar todo model to store in isar db


*/


import 'package:isar/isar.dart';
import 'package:todo_bloc/domain/models/todo.dart';

//to generate isar todo object, run: dart run build_runner build
part 'isar_todo.g.dart';

@collection
class TodoIsar{

  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  //convert isar object into pure todo object to display
  Todo toDomain(){
    return Todo(id: id, text: text, isCompleted: isCompleted,);
  }

  //convert pure todo object into isar object to store in database

  static TodoIsar fromDomain(Todo todo){
    return TodoIsar()
    ..id = todo.id
    ..text = todo.text
    ..isCompleted = todo.isCompleted;
  }

}