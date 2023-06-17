import 'package:flutter/material.dart';
import 'package:tasksfront/controllers/task_controller.dart';
import 'package:tasksfront/models/task.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _endDateController = TextEditingController();
  bool _daily = false;

  @override
  void dispose() {
    _titleController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(
                  labelText: 'End Date',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an end date';
                  }
                  return null;
                },
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    _endDateController.text = picked.toString();
                  }
                },
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Daily'),
                value: _daily,
                onChanged: (value) {
                  setState(() {
                    _daily = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final task = Task(
                      id: 0,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      endDate: DateTime.parse(_endDateController.text),
                      daily: _daily,
                      done: false,
                      title: _titleController.text,
                      deletedAt: null,
                    );
                    await TaskController.createTask(task);
                  }
                },
                child: const Text('Create Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}