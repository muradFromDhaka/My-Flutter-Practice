import 'package:e_commerce_app_flutter/ui/common_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Home"),
      drawer: const CommonDrawer(),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
