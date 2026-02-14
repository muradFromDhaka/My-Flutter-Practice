

import 'dart:convert';

import 'package:http/http.dart' as http;

class RolesetService {

    Future<List<String>> getUsersByRole(String roleName, String jwtToken) async {
    final url = Uri.parse('http://192.168.20.43:8080/api/admin/roles/$roleName/users');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      List users = jsonDecode(response.body);
      return users.map((user) => user['userName'].toString()).toList();
    } else {
      throw Exception("Failed to fetch users");
    }
  }


// Future<void> updateUserRolesUI(String username, List<String> roles, String jwtToken) async {
//   try {
//     await updateUserRoles(username, roles, jwtToken);
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Roles updated successfully')),
//     );
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Failed: $e')),
//     );
//   }
// }



}