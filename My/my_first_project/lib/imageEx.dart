import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("image Example"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(msg: "Elevated button clicked");
              },
              child: Row(
                children: [
                  Icon(Icons.house, size: 30),
                  SizedBox(width: 10),
                  Text("Click Me"),
                ],
              ),
            ),
          ],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: "Elevated button clicked");
                },
                child: Row(
                  children: [
                    Icon(Icons.house, size: 30),
                    SizedBox(width: 10),
                    Text("Click Me"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
