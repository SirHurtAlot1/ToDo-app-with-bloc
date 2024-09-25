/*
  TO DO REPOSITORY

  what the app can do


  the repo in the domain layer shows what operations the app can do, but doesn't specify implemintation details

  this file is a pure dart file. It is independent of any tech or framework



*/

import 'package:todo_bloc/domain/models/todo.dart';

abstract class TodoRepo{

  //get list of todos
  Future<List<Todo>> getTodos();

  //add a new todo
  Future<void> addTodo(Todo newTodo);

  //update todo
  Future<void> updateTodo(Todo todo);

  //delete todo
  Future<void> deleteTodo(Todo todo);
}