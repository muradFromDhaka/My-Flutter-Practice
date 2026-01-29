import 'package:flutter/material.dart';
import 'package:my_first_project/commonDrawerAndAppBar/HomePage.dart';
import 'package:my_first_project/commonDrawerAndAppBar/commonDrowerAndAppbar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Home"),
      drawer: AppDrawer(context: context),
      body: pageBody("About page", Icons.home),
    );
  }
}