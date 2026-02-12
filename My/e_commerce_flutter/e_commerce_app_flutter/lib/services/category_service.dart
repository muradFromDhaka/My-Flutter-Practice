import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app_flutter/models/category.dart';
import 'package:e_commerce_app_flutter/services/api_config.dart';
import 'package:e_commerce_app_flutter/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CategoryService {
  final authservice = AuthService();

  // ✅ GET ALL
  Future<List<Category>> getAllCategories() async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/categories");

    final res = await http.get(
      uri,
      headers: await authservice.headers(auth: true),
    );

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Category.fromJson(e)).toList();
    } 
    else if (res.statusCode == 401) {
      throw Exception("Unauthorized!");
    } 
    else if (res.statusCode == 404) {
      throw Exception("Category not found.");
    }

    throw Exception("Failed to load categories: ${res.statusCode}");
  }

  // ✅ GET BY ID
  Future<Category> getCategoryById(int id) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/categories/$id");

    final res = await http.get(
      uri,
      headers: await authservice.headers(auth: true),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return Category.fromJson(data);
    } 
    else if (res.statusCode == 401) {
      throw Exception("Unauthorized!");
    } 
    else if (res.statusCode == 404) {
      throw Exception("Category not found!");
    }

    throw Exception("Failed: ${res.statusCode}");
  }

  // ✅ CREATE
  Future<bool> createCategory(Category cat, File? categoryImage) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/categories");
    final request = http.MultipartRequest("POST", uri);

    request.headers.addAll(
      await authservice.headers(auth: true, isMultipart: true),
    );

    // JSON part
    request.files.add(
      http.MultipartFile.fromString(
        "category",
        jsonEncode(cat.toJson()),
        contentType: MediaType('application', 'json'),
      ),
    );

    // Image part
    if (categoryImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', categoryImage.path),
      );
    }

    final response = await request.send();
    final resBody = await http.Response.fromStream(response);

    if (resBody.statusCode == 200 || resBody.statusCode == 201) {
      return true;
    }

    throw Exception("Create failed: ${resBody.statusCode} - ${resBody.body}");
  }

  // ✅ UPDATE
  Future<bool> updateCategory(Category category, File? categoryImage) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/categories/${category.id}");
    final request = http.MultipartRequest("PUT", uri);

    request.headers.addAll(
      await authservice.headers(auth: true, isMultipart: true),
    );

    request.files.add(
      http.MultipartFile.fromString(
        "category",
        jsonEncode(category.toJson()),
        contentType: MediaType('application', 'json'),
      ),
    );

    if (categoryImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', categoryImage.path),
      );
    }

    final response = await request.send();
    final resBody = await http.Response.fromStream(response);

    if (resBody.statusCode == 200 || resBody.statusCode == 201) {
      return true;
    }

    throw Exception("Update failed: ${resBody.statusCode} - ${resBody.body}");
  }

  // ✅ DELETE
  Future<bool> deleteCategory(int id) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/categories/$id");

    final res = await http.delete(
      uri,
      headers: await authservice.headers(auth: true),
    );

    if (res.statusCode == 200) {
      return true;
    } 
    else if (res.statusCode == 401) {
      throw Exception("Unauthorized! Cannot delete category.");
    } 
    else if (res.statusCode == 404) {
      throw Exception("Category not found.");
    }

    throw Exception("Delete failed: ${res.statusCode}");
  }
}
