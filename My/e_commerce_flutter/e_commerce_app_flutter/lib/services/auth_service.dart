import 'dart:convert';

import 'package:e_commerce_app_flutter/models/registration.dart';
import 'package:e_commerce_app_flutter/services/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    final res = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/auth/signin"),
      headers: await headers(),
      body: jsonEncode({"username": username, "password": password}),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final token = data['jwtToken'];

      if (token != null && token.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwtToken', token);
        return true;
      }
    }

    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken');
  }

  Future<String> register({required Registration register}) async {
    try {
      final res = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/auth/signup"),
        headers: await headers(),
        body: jsonEncode(register.toJson()), // ✅ use model
      );

      if (res.statusCode == 200) {
        return "Registration successful";
      } else if (res.statusCode == 400) {
        return res.body;
      } else {
        return "Registration failed: ${res.body}";
      }
    } catch (e) {
      return "Something went wrong: $e";
    }
  }

  Future<void> updateUserRoles(
    String username,
    List<String> roles,
    String jwtToken,
  ) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/users/$username/roles');

    final body = jsonEncode({'roles': roles});

    final response = await http.put(
      url,
      headers: await headers(auth: true),
      body: body,
    );

    if (response.statusCode == 200) {
      print("Roles updated successfully");
    } else {
      print("Failed to update roles: ${response.statusCode}");
    }
  }

  // Future<Map<String, String>> headers({bool auth = false}) async {
  //   final token = await getToken();
  //   if (auth && (token == null || token.isEmpty)) {
  //     throw Exception("No JWT token found. Please login first.");
  //   }

  //   final headers = <String, String>{
  //     "Content-Type": "application/json",
  //     if (auth) "Authorization": "Bearer $token",
  //   };

  //   return headers;
  // }

  Future<Map<String, String>> headers({
    bool auth = false,
    bool isMultipart = false,
  }) async {
    final token = await getToken();

    if (auth && (token == null || token.isEmpty)) {
      throw Exception("No JWT token found. Please login first.");
    }

    final headers = <String, String>{
      if (!isMultipart) "Content-Type": "application/json",
      if (auth) "Authorization": "Bearer $token",
    };

    return headers;
  }
}
