import 'package:flutter/material.dart';
import 'package:my_first_project/commonDrawerAndAppBar/HomePage.dart';
import 'package:my_first_project/myPractice/DrawerAndAppBarCommonPractice.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBarr(title: "Profile"),
      drawer: PracticeDrawer(context: context),
      body: pageBody("Profile page", Icons.home),
    );
  }
}
