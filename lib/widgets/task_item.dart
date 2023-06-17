import 'package:flutter/material.dart';
import 'package:tasksfront/controllers/task_controller.dart';
import 'package:tasksfront/models/task.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final VoidCallback? onChecked;

  const TaskItem({super.key, required this.task, required this.onChecked});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.task.id.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          await TaskController.deleteTask(widget.task.id);
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
            widget.onChecked?.call();
          },
        ),
      ),
    );
  }
}
