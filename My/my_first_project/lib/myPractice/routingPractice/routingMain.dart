import 'package:flutter/material.dart';
import 'package:my_first_project/myPractice/routingPractice/brand.dart';
import 'package:my_first_project/myPractice/routingPractice/category.dart';
import 'package:my_first_project/myPractice/routingPractice/home.dart';
import 'package:my_first_project/myPractice/routingPractice/message.dart';
import 'package:my_first_project/myPractice/routingPractice/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Routing Example Practice Demo",
      theme: ThemeData(primarySwatch: Colors.amber),
      darkTheme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/brand": (context) => const Brand(),
        "/category": (context) => const Category(),
        "/proudct": (context) => const Product(),
      },
    );
  }
}
