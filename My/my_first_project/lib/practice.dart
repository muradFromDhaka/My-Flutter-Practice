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
      theme: ThemeData(primarySwatch: Colors.amber),
      darkTheme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text("sunlight e-commerce"),
          titleSpacing: 15,
          toolbarHeight: 70,
          toolbarOpacity: 1,
          backgroundColor: Colors.purpleAccent,
          actions: [
            IconButton(
              onPressed: () {
                print("icon 1 clicked");
              },
              icon: Icon(Icons.search),
              iconSize: 30,
            ),
            IconButton(
              onPressed: () {
                print("icon 3 clicked");
              },
              icon: Icon(Icons.edit),
              iconSize: 30,
            ),
            IconButton(
              onPressed: () {
                print("icon 4 clicked");
              },
              icon: Icon(Icons.delete),
              iconSize: 30,
            ),
            SizedBox(width: 20),
            IconButton(
              onPressed: () {
                print("icon 5 clicked");
              },
              icon: Icon(Icons.dashboard),
              iconSize: 30,
            ),
          ],
        ),
        body: Center(child: Text("Hello Bangladesh")),
      ),
    );
  }
}
