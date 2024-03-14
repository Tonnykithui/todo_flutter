import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/models/todos.dart';

class Todo extends StatelessWidget {

  final Todos? todos;
  final onTodoStatusChange;
  final onTodoDelete;

  const Todo({
    super.key,
    required this.todos,
    required this.onTodoDelete,
    required this.onTodoStatusChange
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: ListTile(
            onTap: () {
              onTodoStatusChange(todos);
            },
            leading: todos?.completed == true
                ? const Icon(
                    Icons.check_box,
                    color: tdBlue,
                  )
                : const Icon(Icons.check_box_outline_blank),
            title: Text(
              todos!.task,
              style: todos?.completed == true
                  ? const TextStyle(decoration: TextDecoration.lineThrough)
                  : const TextStyle(),
            ),
            trailing: Container(
                height: 35,
                width: 35,
                child: Row(children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          onTodoDelete(todos?.id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  )
                ]))));
  }
}
