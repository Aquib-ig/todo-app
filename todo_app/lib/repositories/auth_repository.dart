import 'package:todo_app/models/user_model.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository({AuthService? authService})
      : _authService = authService ?? AuthService();

  // Login user
  Future<UserModel?> login(String email, String password) async {
    return await _authService.login(email, password);
  }

  // Register new user
  Future<UserModel?> register(String name, String email, String password) async {
    return await _authService.register(name, email, password);
  }

  // Get current user profile
  Future<UserModel?> getProfile() async {
    return await _authService.getProfile();
  }

  // Logout user
  Future<void> logout() async {
    return await _authService.logout();
  }
}
