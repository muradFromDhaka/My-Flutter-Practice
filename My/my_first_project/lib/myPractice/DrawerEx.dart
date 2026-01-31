import 'package:flutter/material.dart';
import 'package:my_first_project/myPractice/routingPractice/brand.dart';
import 'package:my_first_project/myPractice/routingPractice/category.dart';
import 'package:my_first_project/myPractice/routingPractice/inventory.dart';
import 'package:my_first_project/myPractice/routingPractice/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Drawer Example Practice!",
      home: DrawerEx(),
      routes: {'/inventory': (context) => const Inventory()},
    );
  }
}

class DrawerEx extends StatelessWidget {
  const DrawerEx({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drawer Example Practice."),
        backgroundColor: Colors.green,
      ),
      body: Center(child: const Text("Welcome to drawer Example Practice.")),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: const Text("Hello"),
              accountEmail: const Text("hello@gamil.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/img5.jpeg"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.branding_watermark),
              title: const Text("Brand"),
              trailing: Icon(Icons.brightness_1_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Brand()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Brand Page loaded successfully."),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: const Text('category'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Category()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text("Product"),
              onTap: () {
                // Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Product()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Product page loaded successfully."),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.inventory),
              title: const Text("inventory"),
              trailing: Icon(Icons.inventory_2_sharp),
              onTap: () {
                Navigator.pushNamed(context, "/inventory");
              },
            ),
          ],
        ),
      ),
    );
  }
}
