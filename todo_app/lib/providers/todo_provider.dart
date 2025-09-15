import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/repositories/todo_repository.dart';

class TodoProvider extends ChangeNotifier {
  final TodoRepository _todoRepository;

  TodoProvider(this._todoRepository);

  List<TodoModel> _todos = [];
  bool _isLoading = false;

  List<TodoModel> get todos => _todos;
  bool get isLoading => _isLoading;

  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();
    try {
      _todos = await _todoRepository.fetchTodos();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTodo(String title) async {
    final todo = await _todoRepository.addTodo(title);
    _todos.insert(0, todo);
    notifyListeners();
  }

  Future<void> toggleTodoCompletion(TodoModel todo) async {
    final updated = await _todoRepository.editTodo(todo.id, {
      "completed": !todo.completed,
    });
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = updated;
      notifyListeners();
    }
  }

  Future<void> deleteTodo(String id) async {
    await _todoRepository.removeTodo(id);
    _todos.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
