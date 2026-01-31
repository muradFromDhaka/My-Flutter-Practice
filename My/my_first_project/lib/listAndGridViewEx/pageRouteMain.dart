import 'package:flutter/material.dart';
import 'package:my_first_project/listAndGridViewEx/page1.dart';
import 'package:my_first_project/listAndGridViewEx/page2.dart';
import 'package:my_first_project/listAndGridViewEx/page3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      darkTheme: ThemeData(primarySwatch: Colors.green),
      home: BTNavigationEx(),
      // initialRoute: "/p1",
      //  initialRoute: (token != null && JwtDecoder.isExpired(token) == false )?"/dash":"/login",
      // routes: {
      //   "/p1": (context) => Page1(),
      //   "/p2": (context) => Page2(),
      //   "/p3": (context) => Page3(),
      //   // "/login": (context) => LoginScreen(),
      //   // MainScreen.idScreen: (context) => MainScreen(),
      //   // ListPage.idScreen: (context) => ListPage(),
      // },
    );
  }
}

class BTNavigationEx extends StatefulWidget {
  const BTNavigationEx({super.key});
  
  @override
  State<BTNavigationEx> createState() => _BTNavigationExState();

}

class _BTNavigationExState extends State<BTNavigationEx> {
  var _currentState = 0;
  final pages = [Page1(), Page2(), Page3()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My App BTNavitation"),

        titleSpacing: 2,
        toolbarHeight: 60,
        toolbarOpacity: 1,
        backgroundColor: Colors.deepPurpleAccent,
        actions: [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlueAccent,
        currentIndex: _currentState,
        items: [
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 1, 111, 236),
            label: "Message",
            icon: Icon(Icons.account_box_outlined),
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 2, 241, 122),
            label: "Call",
            icon: Icon(Icons.call),
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 0, 119, 255),
            label: "Pan Tool",
            icon: Icon(Icons.pan_tool),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentState = index;
          });
        },
      ),
      body: pages[_currentState],
    );
  }
}
