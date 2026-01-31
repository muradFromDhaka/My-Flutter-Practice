import 'package:flutter/material.dart';
import 'package:my_first_project/commonDrawerAndAppBar/commonDrowerAndAppbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Home"),
      // endDrawer: AppDrawer(context: context),
      drawer: AppDrawer(context: context),
      body: pageBody("Home page", Icons.home),
    );
  }
}

Widget pageBody(String title, IconData icon) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 80, color: Colors.blue),
        const SizedBox(height: 16),
        Text(title),
      ],
    ),
  );
}
