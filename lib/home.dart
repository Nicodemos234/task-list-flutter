import 'package:flutter/material.dart';
import 'package:tasksfront/controllers/task_controller.dart';
import 'package:tasksfront/create_task.dart';
import 'package:tasksfront/models/task.dart';
import 'package:tasksfront/widgets/task_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: FutureBuilder<List<Task>>(
        future: TaskController.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Task> tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final Task task = tasks[index];
                return TaskItem(
                  task: task,
                  onChecked: () {setState(() {});},
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the CreateTaskPage to create a new task
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateTaskPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
