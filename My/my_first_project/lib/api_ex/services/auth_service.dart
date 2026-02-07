import 'dart:convert';
import 'package:ay_app/api_ex/services/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  /// Login with username & password
  /// Returns true if login successful
  Future<bool> login(String username, String password) async {
    final res = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/auth/signin"),
      headers: await headers(),//"Content-Type": "application/json",
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
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
  /// Logout user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');
  }

  /// Get saved JWT
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken');
  }

  /// Build headers for HTTP requests
  Future<Map<String, String>> headers({bool auth = false}) async {
    final token = await getToken();

    if (auth && (token == null || token.isEmpty)) {
      throw Exception("No JWT token found. Please login first.");
    }

    final headers = <String, String>{
      "Content-Type": "application/json",
      if (auth) "Authorization": "Bearer $token",
    };

    return headers;
  }
}
