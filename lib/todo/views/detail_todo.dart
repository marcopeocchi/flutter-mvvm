import 'package:flutter/material.dart';
import 'package:mvvm_study/todo/entities/todo.dart';

class DetailsTodoView extends StatelessWidget {
  final Todo todo;

  const DetailsTodoView({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(todo.content),
              ],
            ),
            const Divider(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Completed',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(todo.completed.toString()),
              ],
            ),
            const Divider(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Due date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(todo.dueDate.toString()),
              ],
            ),
            const Divider(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Id',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(todo.id),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
