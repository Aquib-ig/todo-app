import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/user_model.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.0.105:3000/api';
  final storage = const FlutterSecureStorage();

  // REGISTER
  Future<UserModel?> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        log(data.toString());
        
        // Save token after registration
        await storage.write(key: "accessToken", value: data["data"]["accessToken"]);
        
        return UserModel.fromJson(data["data"]["user"]);
      } else {
        throw Exception("Something went wrong: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  // LOGIN
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) { // Fix: Changed from 201 to 200
        final data = jsonDecode(response.body);
        log(data.toString());

        // Save token securely
        await storage.write(key: "accessToken", value: data["data"]["accessToken"]);

        // Convert user JSON to model
        return UserModel.fromJson(data["data"]["user"]);
      } else {
        throw Exception("Login failed: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get User
  Future<UserModel?> getProfile() async {
    try {
      final token = await storage.read(key: "accessToken");
      if (token == null) throw Exception("No access token found");

      final response = await http.get(
        Uri.parse("$baseUrl/auth/profile"),
        headers: {
          "Content-Type": "application/json", // Fix: Changed header name
          "Authorization": "Bearer $token",   // Fix: Added Authorization header
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data["data"]["user"]); // Fix: Updated path
      } else {
        throw Exception("Failed to fetch profile: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    await storage.delete(key: "accessToken");
  }
}
