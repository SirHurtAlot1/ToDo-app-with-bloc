/*

    simple state managment

    each cubit is a list of todos

  */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/models/todo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  // reference todo repo
  final TodoRepo todoRepo;

  //constructor to initialize the cubit with an empty list
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  //load
  Future<void> loadTodos() async {
    //get list of todos from repository
    //it checks the implemention in isar_todo_repo.dart
    final todoList = await todoRepo.getTodos();

    //emit this list as a new state
    emit(todoList);
  }

  //add
  Future<void> addTodo(String text) async {
    //create new todo with unique ID
    final newTodo = Todo(
      id: DateTime.now().microsecondsSinceEpoch,
      text: text,
    );

    //save to repo
    await todoRepo.addTodo(newTodo);

    //reload
    loadTodos();
  }

  //delete
  Future<void> deleteTodo(Todo todo) async{
    //delete from repo
    await todoRepo.deleteTodo(todo);

    //reload
    loadTodos();
  }

  //toggle
  Future<void> toggleCompletion(Todo todo) async{
    //toggle the completion status of todo
    final updatedTodo = todo.toggleCompletion();

    //update in repo
    await todoRepo.updateTodo(updatedTodo);

    //reload
    loadTodos();

  }
}
