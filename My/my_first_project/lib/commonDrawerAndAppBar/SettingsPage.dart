import 'package:flutter/material.dart';
import 'package:my_first_project/commonDrawerAndAppBar/HomePage.dart';
import 'package:my_first_project/commonDrawerAndAppBar/commonDrowerAndAppbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Settings"),
      drawer: AppDrawer(context: context),
      body: pageBody("Settings page", Icons.home),
    );
  }
}