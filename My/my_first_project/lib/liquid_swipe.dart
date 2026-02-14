import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

void main() {
  runApp(LiquidSwipeExample());
}

class LiquidSwipeExample extends StatelessWidget {
  LiquidSwipeExample({super.key});

  final pagesArray = [
    Container(
      height: 100,
      width: 100,
      child: Text("Hello"),
      color: Colors.amber,
    ),
    Container(
      height: 100,
      width: 100,
      child: Text("Hello"),
      color: Colors.deepOrange,
    ),
    Container(
      height: 100,
      width: 100,
      child: Text("Hello"),
      color: Colors.deepPurpleAccent,
    ),
    Container(
      height: 100,
      width: 100,
      child: Text("Hello"),
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Liquid Swipe")),
          body: LiquidSwipe(pages: pagesArray),
        ),
      ),
    );
  }
}
