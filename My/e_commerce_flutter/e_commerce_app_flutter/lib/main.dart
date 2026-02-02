import 'package:e_commerce_app_flutter/homePage.dart';
import 'package:e_commerce_app_flutter/screens/Product_Details_Screen.dart';
import 'package:e_commerce_app_flutter/screens/User_Profile_Screen.dart';
import 'package:e_commerce_app_flutter/screens/Vendor_Profile_Screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

// main.dart

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
      darkTheme: ThemeData(primarySwatch: Colors.amber),
      title: 'e-commerce app',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        // '/': (context) => HomeScreen(),
        // '/proudct': (context) => ProductDetailsScreen(),
        // '/user': (context) => UserProfileScreen(),
        // '/vendor': (context) => VendorProfileScreen(),
      },
    );
  }
}

//==================== common appbar====================
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CommonAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleSpacing: 20,
      toolbarOpacity: 1,
      backgroundColor: Colors.deepPurpleAccent,
      actions: const [
        Icon(Icons.notifications),
        SizedBox(width: 8),
        Icon(Icons.settings),
        SizedBox(width: 8),
        Icon(Icons.dashboard),
        SizedBox(width: 8),
      ],
    );
  }
}

// ==========================Common Drower========================
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void navigate(BuildContext context, String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("MURAD"),
            accountEmail: Text("murad@gmail.com"),
            decoration: BoxDecoration(color: Colors.blue),
            currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => navigate(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text("Products"),
            onTap: () => navigate(context, '/proudct'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("User Profile"),
            onTap: () => navigate(context, '/user'),
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Vendor"),
            onTap: () => navigate(context, '/vendor'),
          ),
        ],
      ),
    );
  }
}
