import 'package:e_commerce_app_flutter/services/roleset_service.dart';
import 'package:flutter/material.dart';

class UsersByRolePage extends StatefulWidget {
  final String roleName;
  final String jwtToken;

  const UsersByRolePage({
    super.key,
    required this.roleName,
    required this.jwtToken,
  });

  @override
  State<UsersByRolePage> createState() => _UsersByRolePageState();
}

class _UsersByRolePageState extends State<UsersByRolePage> {
  late Future<List<String>> _usersFuture;

  final _roll = RolesetService();

  @override
  void initState() {
    super.initState();
    _usersFuture = _roll.getUsersByRole(widget.roleName, widget.jwtToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users with role ${widget.roleName}')),
      body: FutureBuilder<List<String>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(users[index]),
                trailing: Icon(Icons.person),
              );
            },
          );
        },
      ),
    );
  }
}
