import 'dart:convert';
import 'package:my_first_project/APICallExample/models/products.dart';
import 'package:my_first_project/api_ex/services/api_config.dart';
import 'package:my_first_project/api_ex/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import '../models/product.dart';

class ProductApiService {
  // static const String baseUrl =
  //     "https://rander-secqurity-3.onrender.com/api/products";

  final authService = AuthService();

  // /// Get JWT token from SharedPreferences
  // Future<String?> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('jwtToken');
  // }

  // /// Build headers for HTTP requests
  // Future<Map<String, String>> _headers({bool auth = false}) async {
  //   final token = await getToken();
  //   // final headers = await AuthService.getAuthHeaders();

  //   if (auth && (token == null || token.isEmpty)) {
  //     throw Exception("No JWT token found. Please login first.");
  //   }

  //   final headers = {
  //     "Content-Type": "application/json",
  //     if (auth) "Authorization": "Bearer $token",
  //   };

  //   print("==== HTTP Headers ====");
  //   headers.forEach((k, v) => print("$k: $v"));
  //   print("=====================");

  //   return headers;
  // }

  /// 🔓 GET all products
  Future<List<Product>> getAllProducts() async {
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/products"),
      headers: await authService.headers(auth: true),
    );

    print('---------------URI-- ${Uri.parse(baseUrl)}');
    print("GET /products -> Status: ${res.statusCode}");
    print("Response: ${res.body}");

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized! Invalid or expired token.");
    } else {
      throw Exception("Failed to load products: ${res.body}");
    }
  }

  /// 🔐 GET product by ID
  Future<Product> getProductById(int id) async {
    final res = await http.get(
      Uri.parse("$baseUrl/$id"),
      headers: await authService.headers(auth: true),
    );

    print("GET /products/$id -> Status: ${res.statusCode}");
    print("Response: ${res.body}");

    if (res.statusCode == 200) {
      return Product.fromJson(jsonDecode(res.body));
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized! Invalid token.");
    } else if (res.statusCode == 404) {
      throw Exception("Product not found.");
    } else {
      throw Exception("Error fetching product: ${res.body}");
    }
  }

  /// 🛡 CREATE product
  Future<Product> createProduct(Product product) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: await authService.headers(auth: true),
      body: jsonEncode(product.toJson()),
    );

    print("POST /products -> Status: ${res.statusCode}");
    print("Response: ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      return Product.fromJson(jsonDecode(res.body));
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized! Cannot create product.");
    } else {
      throw Exception("Create failed: ${res.body}");
    }
  }

  /// 📝 UPDATE product
  Future<Product> updateProduct(int id, Product product) async {
    final res = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: await authService.headers(auth: true),
      body: jsonEncode(product.toJson()),
    );

    print("PUT /products/$id -> Status: ${res.statusCode}");
    print("Response: ${res.body}");

    if (res.statusCode == 200) {
      return Product.fromJson(jsonDecode(res.body));
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized! Cannot update product.");
    } else {
      throw Exception("Update failed: ${res.body}");
    }
  }

  /// ❌ DELETE product
  Future<void> deleteProduct(int id) async {
    final res = await http.delete(
      Uri.parse("$baseUrl/$id"),
      headers: await authService.headers(auth: true),
    );

    print("DELETE /products/$id -> Status: ${res.statusCode}");
    print("Response: ${res.body}");

    if (res.statusCode != 200 && res.statusCode != 204) {
      if (res.statusCode == 401) {
        throw Exception("Unauthorized! Cannot delete product.");
      } else if (res.statusCode == 404) {
        throw Exception("Product not found.");
      } else {
        throw Exception("Delete failed: ${res.body}");
      }
    }
  }

  /// Clear JWT token (logout)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');
    print("JWT token cleared. User logged out.");
  }
}
