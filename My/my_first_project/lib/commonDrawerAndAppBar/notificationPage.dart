import 'package:flutter/material.dart';
import 'package:my_first_project/commonDrawerAndAppBar/HomePage.dart';
import 'package:my_first_project/commonDrawerAndAppBar/commonDrowerAndAppbar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Notifications"),
      drawer: AppDrawer(context: context),
      body: pageBody("Notification page", Icons.home),
    );
  }
}