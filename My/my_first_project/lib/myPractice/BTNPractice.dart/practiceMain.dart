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
        titleSpacing: 20,
        actions: [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: _currentState,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Message",
            backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Gird",
            backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_3x3),
            label: "List",
            backgroundColor: Colors.yellow,
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
