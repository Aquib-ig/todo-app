import 'package:flutter/material.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  UserModel? _userModel;
  bool _isLoading = false;
  String? _errorMessage;

  // Add secure storage
  final _storage = const FlutterSecureStorage();

  AuthProvider({AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository();

  UserModel? get user => _userModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _userModel != null;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Check auth status on app startup
  Future<void> checkAuthStatus() async {
    try {
      final token = await _storage.read(key: "accessToken");
      if (token != null) {
        // Try to get user profile
        _userModel = await _authRepository.getProfile();
        notifyListeners();
      }
    } catch (e) {
      // Token might be expired, clear it
      await _storage.delete(key: "accessToken");
      _userModel = null;
      notifyListeners();
    }
  }

  // Login
  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      _userModel = await _authRepository.login(email, password);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Register
  Future<void> register(String name, String email, String password) async {
    _setLoading(true);
    try {
      _userModel = await _authRepository.register(name, email, password);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Get profile
  Future<void> fetchProfile() async {
    _setLoading(true);
    try {
      _userModel = await _authRepository.getProfile();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Logout
  Future<void> logout() async {
    await _authRepository.logout();
    _userModel = null;
    notifyListeners();
  }
}
