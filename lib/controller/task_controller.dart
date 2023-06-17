import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tasksfront/models/task.dart';

class TaskController {
  static const String _baseUrl = 'http://localhost:8082/tasks';

  static Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  static Future<Task> createTask(Task task) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode == 201) {
      final dynamic json = jsonDecode(response.body);
      return Task.fromJson(json);
    } else {
      throw Exception('Failed to create task');
    }
  }

  static Future<Task> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      return Task.fromJson(json);
    } else {
      throw Exception('Failed to update task');
    }
  }

  static Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete task');
    }
  }
}
