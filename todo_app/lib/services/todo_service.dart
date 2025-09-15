import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo_model.dart';

class TodoService {
  static const String baseUrl = 'http://192.168.0.105:3000/api';
  final storage = const FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await storage.read(key: "accessToken");
  }

  // GET Todos
  Future<List<TodoModel>> getTodos() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/todos"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    log("GET TODOS -> ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List todosJson = data["data"]["todos"];
      return todosJson.map((t) => TodoModel.fromJson(t)).toList();
    } else {
      throw Exception("Failed to fetch todos: ${response.body}");
    }
  }

  // CREATE Todo
  Future<TodoModel> createTodo(String title) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/todos"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"title": title}),
    );

    log("CREATE TODO -> ${response.body}");

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return TodoModel.fromJson(data["data"]["todo"]);
    } else {
      throw Exception("Failed to create todo: ${response.body}");
    }
  }

  // UPDATE Todo
  Future<TodoModel> updateTodo(String id, Map<String, dynamic> updates) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse("$baseUrl/todos/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(updates),
    );

    log("UPDATE TODO -> ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return TodoModel.fromJson(data["data"]["todo"]);
    } else {
      throw Exception("Failed to update todo: ${response.body}");
    }
  }

  // DELETE Todo
  Future<void> deleteTodo(String id) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse("$baseUrl/todos/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    log("DELETE TODO -> ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Failed to delete todo: ${response.body}");
    }
  }
}
