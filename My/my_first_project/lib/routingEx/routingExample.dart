import 'package:flutter/material.dart';
import 'package:my_first_project/routingEx/aboutPage.dart';
import 'package:my_first_project/routingEx/contactPage.dart';
import 'package:my_first_project/routingEx/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Routing Demo",
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/about': (context) => const Aboutpage(),
        '/contact': (context) => const ContactPage(),
      },
    );
  }
}
