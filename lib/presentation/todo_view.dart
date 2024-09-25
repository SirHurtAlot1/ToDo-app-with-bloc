/*
  THIS IS UI

  use BlocBuilder


*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/models/todo.dart';
import 'package:todo_bloc/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  //show dialog for user to type
  _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(controller: textController),
              actions: [
                //cancel btn
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel')),

                //add btn
                TextButton(
                    onPressed: () {
                      todoCubit.addTodo(textController.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    //todo cubit

    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoBox(context),
        child: const Icon(Icons.add),
      ),

      //Bloc builder
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              //get individual object from the list
              final todo = todos[index];

              //List tile

              return ListTile(
                //text
                title: Text(todo.text),

                //checkbox
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.toggleCompletion(todo),
                ),

                //delete btn
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => todoCubit.deleteTodo(todo),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
