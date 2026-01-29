import 'package:flutter/material.dart';

// Contact Page - named route
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          // onPressed: () {
          //   Navigator.pushNamed(context, '/about');
          // },
          child: const Text("Go Back"),
        ),
      ),
    );
  }
}