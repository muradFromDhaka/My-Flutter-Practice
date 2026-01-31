import 'package:flutter/material.dart';
import 'package:my_first_project/crud_SQLite/screens/user_form.dart';
import 'package:my_first_project/crud_SQLite/screens/user_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const UserList(),
      routes: {"/": (context) => UserList(), "/form": (context) => UserForm()},
    );
  }
}
