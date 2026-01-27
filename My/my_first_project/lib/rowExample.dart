import 'package:flutter/material.dart';

void main() {
  runApp(Practice4());
}

class Practice3 extends StatelessWidget {
  const Practice3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      darkTheme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Row Example"),
          titleSpacing: 15,
          toolbarHeight: 60,
          toolbarOpacity: 1,
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(height: 100, width: 100, color: Colors.red),
              Container(height: 100, width: 100, color: Colors.green),
              Container(height: 100, width: 100, color: Colors.yellow),
              Container(height: 100, width: 100, color: Colors.purple),
              Container(height: 100, width: 100, color: Colors.red),
              Container(height: 100, width: 100, color: Colors.green),
              Container(height: 100, width: 100, color: Colors.yellow),
              Container(height: 100, width: 100, color: Colors.purple),
              Container(height: 100, width: 100, color: Colors.purple),
              Container(height: 100, width: 100, color: Colors.red),
              Container(height: 100, width: 100, color: Colors.green),
              Container(height: 100, width: 100, color: Colors.yellow),
              Container(height: 100, width: 100, color: Colors.purple),
            ],
          ),
        ),
      ),
    );
  }
}

class Practice4 extends StatelessWidget {
  const Practice4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      darkTheme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Row Example"),
          titleSpacing: 15,
          toolbarHeight: 60,
          toolbarOpacity: 1,
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(width: 120, height: double.infinity, color: Colors.red),
              Container(
                width: 100,
                height: double.infinity,
                color: Colors.green,
              ),
              Container(
                width: 140,
                height: double.infinity,
                color: Colors.yellow,
              ),
              Container(width: 120, height: double.infinity, color: Colors.red),
              Container(
                width: 100,
                height: double.infinity,
                color: Colors.green,
              ),
              Container(
                width: 80,
                height: double.infinity,
                color: Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


