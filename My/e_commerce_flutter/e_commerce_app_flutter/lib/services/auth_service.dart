import 'dart:convert';

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
