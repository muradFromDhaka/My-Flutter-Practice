import 'package:flutter/material.dart';
import 'package:my_first_project/commonDrawerAndAppBar/HomePage.dart';
import 'package:my_first_project/commonDrawerAndAppBar/commonDrowerAndAppbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Profile"),
      drawer: AppDrawer(context: context),
      body: pageBody("Profile page", Icons.home),
    );
  }
}