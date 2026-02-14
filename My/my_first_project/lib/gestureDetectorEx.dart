import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: GestureDtor(),
    );
  }
}

class GestureDtor extends StatelessWidget {
  const GestureDtor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text app")),
      body: Center(
        child: GestureDetector(
          child: Hero(
            tag: "product",
            child: Container(
              height: 300,
              width: 300,
              child: Column(
                children: [
                  ClipOval(
                    // borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/w7.png",
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("View Product"),
                ],
              ),
            ),
          ),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (_) => HomePage()),
            // );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("This is gestureDetector message")),
            );
          },
        ),
      ),
    );
  }
}
