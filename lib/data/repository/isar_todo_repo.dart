/*

  DATABASE REPOSITORY

  HANDLES UPDATING, INSERTING, DELETING, ADDING

*/

import 'package:isar/isar.dart';
import 'package:todo_bloc/data/models/isar_todo.dart';
import 'package:todo_bloc/domain/models/todo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo{

  //database

  final Isar db;

  IsarTodoRepo(this.db);

  //add todo
  @override
  Future<void> addTodo(Todo newTodo) async{
    //convert todo to IsarTodo
    final todoIsar = TodoIsar.fromDomain(newTodo);
    
    return db.writeTxn(()=>db.todoIsars.put(todoIsar));
    
  }

  //update todo
  @override
  Future<void> updateTodo(Todo todo) {
    //convert todo to IsarTodo
    final todoIsar = TodoIsar.fromDomain(todo);
    
    return db.writeTxn(()=>db.todoIsars.put(todoIsar));
  }

  //delete todo
  @override
  Future<void> deleteTodo(Todo todo) async{
    

    await db.writeTxn(()=>db.todoIsars.delete(todo.id));  
  }

  //get todos
  @override
  Future<List<Todo>> getTodos() async {
   //fetch from database
   final todos = await db.todoIsars.where().findAll();


   //return list of todos and give to the domain layer
   return todos.map((todoIsar)=>todoIsar.toDomain()).toList();
  }

}