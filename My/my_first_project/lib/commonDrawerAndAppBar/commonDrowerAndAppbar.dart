import 'package:flutter/material.dart';
import 'package:my_first_project/commonDrawerAndAppBar/HomePage.dart'
    show HomePage;
import 'package:my_first_project/commonDrawerAndAppBar/ProfilePage.dart'
    show ProfilePage;
import 'package:my_first_project/commonDrawerAndAppBar/SettingsPage.dart';
import 'package:my_first_project/commonDrawerAndAppBar/aboutPage.dart';
import 'package:my_first_project/commonDrawerAndAppBar/notificationPage.dart'
    show NotificationPage;

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
      title: 'Common AppBar Demo',
      home: HomePage(),
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
      centerTitle: true,
      backgroundColor: Colors.blue,
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
  final BuildContext context;
  const AppDrawer({super.key, required this.context});

  void navigate(Widget page) {
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("MURAD"),
            accountEmail: Text("dfsfsdf"),
            decoration: BoxDecoration(color: Colors.blue),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
              // backgroundImage: NetworkImage("dfdfdffffffffffff"),
              backgroundImage: AssetImage("sddddddddddddd"),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => navigate(const HomePage()),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () => navigate(const ProfilePage()),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notification"),
            onTap: () => navigate(const NotificationPage()),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () => navigate(const SettingsPage()),
          ),
          ListTile(
            leading: const Icon(Icons.abc),
            title: const Text("About"),
            onTap: () => navigate(const AboutPage()),
          ),
        ],
      ),
    );
  }
}
