import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My App"), actions: []),
      body: ListView(
        children: [
          Container(
            color: Colors.amber,
            height: 250,
            width: 250,
            child: TextButton(onPressed: () {}, child: Text("Routing-1")),
          ),
          Container(
            color: const Color.fromARGB(255, 40, 238, 0),
            height: 250,
            width: 250,
            child: TextButton(onPressed: () {}, child: Text("Routing-1")),
          ),
          Container(
            color: const Color.fromARGB(255, 217, 2, 224),
            height: 250,
            width: 250,
            child: TextButton(onPressed: () {}, child: Text("Routing-1")),
          ),
        ],
      ),
    );
  }
}