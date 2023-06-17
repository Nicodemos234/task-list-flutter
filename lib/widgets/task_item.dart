import 'package:flutter/material.dart';
import 'package:tasksfront/controllers/task_controller.dart';
import 'package:tasksfront/models/task.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.task.id.toString()),
      direction: DismissDirection.horizontal,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.check, color: Colors.white),
      ),
      onDismissed: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          await TaskController.deleteTask(widget.task.id);
        } else if (direction == DismissDirection.endToStart) {
          await TaskController.updateTask(widget.task.copyWith(done: true));
        }
        // Reload the tasks after deleting or updating one
        setState(() {});
      },
      child: ListTile(
        title: Text(widget.task.title),
        subtitle: Text(widget.task.endDate.toString()),
        trailing: Checkbox(
          value: widget.task.done,
          onChanged: (value) async {
            await TaskController.updateTask(widget.task.copyWith(done: value ?? false));
            // Reload the tasks after updating one
            setState(() {});
          },
        ),
      ),
    );
  }
}
