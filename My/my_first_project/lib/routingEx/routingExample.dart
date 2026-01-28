import 'package:flutter/material.dart';
import 'package:my_first_project/routingEx/ProfilePage.dart';
import 'package:my_first_project/routingEx/aboutPage.dart';
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
        '/': (context) => HomePage(),
        '/about': (context) => Aboutpage(),
        // '/message': (context) => MessagePage(message: "Hello from message page"),
      },
    );
  }
}
