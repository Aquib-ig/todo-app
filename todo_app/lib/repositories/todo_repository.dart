import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/todo_service.dart';

class TodoRepository {
  final TodoService _todoService;

  TodoRepository(this._todoService);

  Future<List<TodoModel>> fetchTodos() => _todoService.getTodos();
  Future<TodoModel> addTodo(String title) => _todoService.createTodo(title);
  Future<TodoModel> editTodo(String id, Map<String, dynamic> updates) =>
      _todoService.updateTodo(id, updates);
  Future<void> removeTodo(String id) => _todoService.deleteTodo(id);
}
