import 'package:flutter/material.dart';
import 'package:my_first_project/myPractice/BTNPractice.dart/navigationPage1.dart';
import 'package:my_first_project/myPractice/BTNPractice.dart/navigationPage2.dart';
import 'package:my_first_project/myPractice/BTNPractice.dart/navigationPage3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Practice AppBar",
      theme: ThemeData(primarySwatch: Colors.green),
      darkTheme: ThemeData(primarySwatch: Colors.yellow),
      home: BTNavigation(),
    );
  }
}

class BTNavigation extends StatefulWidget {
  const BTNavigation({super.key});

  @override
  State<BTNavigation> createState() => _BTNavigationState();
}

class _BTNavigationState extends State<BTNavigation> {
  var _currentState = 0;
  final pages = [Navigationpage1(), Navigationpage2(), Navigationpage3()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Navigation Example."),
        toolbarHeight: 60,
        toolbarOpacity: 1,
        titleSpacing: 15,
        backgroundColor: const Color.fromARGB(255, 0, 238, 255),
        actions: [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        currentIndex: _currentState,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            label: "Message",
            icon: Icon(Icons.message),
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 0, 255, 234),
            label: "GridView",
            icon: Icon(Icons.message),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            label: "ListView",
            icon: Icon(Icons.message),
          ),
        ],
        onTap: (value) => setState(() {
          _currentState = value;
        }),
      ),
      body: pages[_currentState],
    );
  }
}
