import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app_flutter/models/brand.dart';
import 'package:e_commerce_app_flutter/services/api_config.dart';
import 'package:e_commerce_app_flutter/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BrandService {
  final AuthService authService = AuthService();

  /// 🔓 GET all products
  Future<List<Brand>> getAllBrands() async {
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/brands"),
      headers: await authService.headers(auth: true),
    );

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
      final data = jsonDecode(res.body);
      return Brand.fromJson(data);
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized! Invalid token.");
    } else if (res.statusCode == 404) {
      throw Exception("Brand not found.");
    } else {
      throw Exception("Error fetching brand: ${res.body}");
    }
  }

  // 📝 CREATE brand with multipart/form-data
  // ===========================================
  Future<void> createBrand(Brand brand, File? image) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/brands");
    final request = http.MultipartRequest('POST', uri);

    // 🔐 Token
    // final token = await authService.getToken();
    // if (token == null || token.isEmpty) {
    //   throw Exception("No JWT token found. Please login first.");
    // }
    // request.headers['Authorization'] = 'Bearer $token';

    request.headers.addAll(
      await authService.headers(auth: true, isMultipart: true),
    );

    // ✅ Brand JSON Part
    request.files.add(
      http.MultipartFile.fromString(
        'brand', // MUST match backend @RequestPart("brand")
        jsonEncode(brand.toJson()),
        contentType: MediaType('application', 'json'),
      ),
    );

    // ✅ Image Part
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'logo', // MUST match backend @RequestPart("logo")
          image.path,
        ),
      );
    }

    // 🚀 Send Request
    final response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("✅ Brand created successfully");
    } else {
      final resBody = await response.stream.bytesToString();
      print("❌ Error: ${response.statusCode} - $resBody");
    }
  }

  /// 📝 UPDATE brand
  Future<void> updateBrand(Brand brand, File? image) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/brands/${brand.id}");
    final request = http.MultipartRequest('PUT', uri);

    // final token = await authService.getToken();
    // request.headers['Authorization'] = 'Bearer $token';
    request.headers.addAll(
      await authService.headers(auth: true, isMultipart: true),
    );

    // JSON part
    request.files.add(
      http.MultipartFile.fromString(
        'brand',
        jsonEncode(brand.toJson()),
        contentType: MediaType('application', 'json'),
      ),
    );

    // Optional image
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('logo', image.path));
    }

    final response = await request.send();
    final resBody = await http.Response.fromStream(response);

    print(resBody.statusCode);
    print(resBody.body);
  }


  /// ❌ DELETE brand
 // ===========================================
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
