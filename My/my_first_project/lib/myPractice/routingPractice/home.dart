import 'package:flutter/material.dart';
import 'package:my_first_project/myPractice/routingPractice/brand.dart';
import 'package:my_first_project/myPractice/routingPractice/category.dart';
import 'package:my_first_project/myPractice/routingPractice/checkout.dart';
import 'package:my_first_project/myPractice/routingPractice/inventory.dart';
import 'package:my_first_project/myPractice/routingPractice/message.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Text("Routing List Page")),
          SizedBox(height: 200),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Brand()),
              );
            },
            child: Text("Go Brand Page"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Category()),
              );
            },
            child: Text("go Categorty Page"),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/proudct');
            },
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.production_quantity_limits, size: 20),
                SizedBox(width: 10),
                Text("Go Product Page"),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Inventory()),
              );
            },
            child: Text("Go to inventory ( pushReplacement )"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const Message(message: "This message Comes from home"),
                ),
              );
            },
            child: Text("Go to Message"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Checkout()),
                (route) => false,
              );
            },
            child: Text("Go to Checkout (pushAndRemoveUntil)"),
          ),
        ],
      ),
    );
  }
}
