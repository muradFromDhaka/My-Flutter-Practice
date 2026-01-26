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
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      darkTheme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello Title"),
          titleSpacing: 15,
          toolbarHeight: 60,
          toolbarOpacity: 1,
          elevation: 20,
          backgroundColor: Colors.blueAccent,
          actions: [
            IconButton(
              onPressed: () {
                print("Button 1 Clicked");
              },
              icon: Icon(Icons.dashboard_outlined),
            ),
            SizedBox(width: 15),
            IconButton(
              onPressed: () {
                print("Button 2 Clicked");
              },
              icon: Icon(Icons.dangerous_sharp),
            ),
            IconButton(
              onPressed: () {
                print("Button 2.5 Clicked");
              },
              icon: Icon(Icons.back_hand),
            ),
            IconButton(
              onPressed: () {
                print("Button 3 Clicked");
              },
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                print("Button 4 Clicked");
              },
              icon: Icon(Icons.home),
            ),
            SizedBox(width: 10),
          ],
        ),
        body: Center(child: Text('Hello World')),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleSpacing: 10,
      toolbarHeight: 60,
      toolbarOpacity: 1,
      elevation: 10,
      backgroundColor: Colors.blueAccent,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/p1');
          },
          icon: Icon(Icons.accessible),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/p2');
          },
          icon: Icon(Icons.dangerous_sharp),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/p3');
          },
          icon: Icon(Icons.back_hand),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/p4');
          },
          icon: Icon(Icons.home),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/p5');
          },
          icon: Icon(Icons.home),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
