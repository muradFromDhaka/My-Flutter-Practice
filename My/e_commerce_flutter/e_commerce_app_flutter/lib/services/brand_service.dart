import 'dart:convert';

import 'package:e_commerce_app_flutter/models/brand.dart';
import 'package:e_commerce_app_flutter/services/api_config.dart';
import 'package:e_commerce_app_flutter/services/auth_service.dart';
import 'package:http/http.dart' as http;

class BrandService {
  final AuthService authService = AuthService();

  /// 🔓 GET all products
  Future<List<Brand>> getAllBrands() async {
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/brands"),
      headers: await authService.headers(auth: true),
    );

    // print("GET -> Status: ${res.statusCode}");
    // print("Response: ${res.body}");

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Brand.fromJson(e)).toList();
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized! Invalid or expired token.");
    } else {
      throw Exception("Failed to load brands: ${res.body}");
    }
  }

  /// 🔐 GET brand by ID
  Future<Brand> getBrandById(int id) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/brands/$id");

    final res = await http.get(
      uri,
      headers: await authService.headers(auth: true),
    );

    if (res.statusCode == 200) {
      return Brand.fromJson(jsonDecode(res.body));
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized! Invalid token.");
    } else if (res.statusCode == 404) {
      throw Exception("Brand not found.");
    } else {
      throw Exception("Error fetching brand: ${res.body}");
    }
  }

  /// 🛡 CREATE brand
  Future<Brand> createBrand(Brand brand) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/brands");

    final res = await http.post(
      uri,
      headers: await authService.headers(auth: true),
      body: jsonEncode(brand.toJson()),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return Brand.fromJson(jsonDecode(res.body));
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized! Cannot create brand.");
    } else {
      throw Exception("Create failed: ${res.body}");
    }
  }

  /// 📝 UPDATE brand
  Future<Brand> updateBrand(int id, Brand brand) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/brands/$id");

    final res = await http.put(
      uri,
      headers: await authService.headers(auth: true),
      body: jsonEncode(brand.toJson()),
    );

    if (res.statusCode == 200) {
      return Brand.fromJson(jsonDecode(res.body));
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized! Cannot update brand.");
    } else {
      throw Exception("Update failed: ${res.body}");
    }
  }

  /// ❌ DELETE brand
  Future<void> deleteBrand(int id) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/brands/$id");

    final res = await http.delete(
      uri,
      headers: await authService.headers(auth: true),
    );

    if (res.statusCode != 200 && res.statusCode != 204) {
      if (res.statusCode == 401) {
        throw Exception("Unauthorized! Cannot delete brand.");
      } else if (res.statusCode == 404) {
        throw Exception("Brand not found.");
      } else {
        throw Exception("Delete failed: ${res.body}");
      }
    }
  }
}
