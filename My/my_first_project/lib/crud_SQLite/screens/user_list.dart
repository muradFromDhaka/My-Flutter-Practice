import 'dart:io';

import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../model/user.dart';
import 'user_form.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> users = [];

  Future<void> fetchUsers() async {
    users = await DatabaseHelper().getUsers();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UserForm()),
          );
          fetchUsers();
        },
      ),
      body: users.isEmpty
          ? const Center(child: Text('No users found'))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, i) {
                final u = users[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: u.imagePath != null
                        ? CircleAvatar(
                            radius: 25,
                            backgroundImage: FileImage(File(u.imagePath!)),
                          )
                        : const CircleAvatar(
                            radius: 25,
                            child: Icon(Icons.person),
                          ),
                    title: Text(u.name),
                    subtitle: Text('${u.email} / ${u.gender}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => UserForm(user: u)),
                            );
                            fetchUsers();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await DatabaseHelper().deleteUser(u.id!);
                            fetchUsers();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
