import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoist_test/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(todo.name),
                Text(dateFormat.format(todo.date)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(todo.priority.name),
                Text(todo.tag),
              ],
            ),
            const SizedBox(height: 16),
            Text(todo.description),
          ],
        ),
      ),
    );
  }
}
