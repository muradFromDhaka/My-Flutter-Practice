import 'package:flutter/material.dart';

class page2 extends StatelessWidget {
  const page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          Container(
            color: const Color.fromARGB(255, 102, 255, 0),
            height: 250,
            width: 250,
            child: TextButton(onPressed: () {}, child: Text("Routing-1")),
          ),
          Container(
            color: const Color.fromARGB(255, 78, 235, 149),
            height: 250,
            width: 250,
            child: TextButton(onPressed: () {}, child: Text("Routing-1")),
          ),
          Container(
            color: const Color.fromARGB(255, 0, 57, 245),
            height: 250,
            width: 250,
            child: TextButton(onPressed: () {}, child: Text("Routing-1")),
          ),
          Container(
            color: const Color.fromARGB(255, 255, 0, 200),
            height: 250,
            width: 250,
            child: TextButton(onPressed: () {}, child: Text("Routing-1")),
          ),
          Container(
            color: Colors.amber,
            height: 250,
            width: 250,
            child: TextButton(onPressed: () {}, child: Text("Routing-1")),
          ),
          Container(
            color: const Color.fromARGB(255, 0, 243, 109),
            height: 250,
            width: 250,
            child: TextButton(onPressed: () {}, child: Text("Routing-1")),
          ),
          Container(
            color: const Color.fromARGB(255, 0, 57, 245),
            height: 250,
            width: 250,
            child: TextButton(onPressed: () {}, child: Text("Routing-1")),
          ),
          Container(
            color: const Color.fromARGB(255, 255, 0, 200),
            height: 250,
            width: 250,
            child: TextButton(onPressed: () {}, child: Text("Routing-1")),
          ),
        ],
      ),
    );
  }
}
