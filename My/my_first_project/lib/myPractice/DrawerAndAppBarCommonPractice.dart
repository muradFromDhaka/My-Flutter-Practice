import 'package:flutter/material.dart';
import 'package:my_first_project/commonDrawerAndAppBar/HomePage.dart';
import 'package:my_first_project/commonDrawerAndAppBar/ProfilePage.dart';

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
      home: ProfilePage(),
    );
  }
}

// ===========commonAppBar=========================
class CommonAppBarr extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CommonAppBarr({super.key, required this.title});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(fontSize: 40)),
      titleSpacing: 15,
      toolbarOpacity: 1,
      backgroundColor: Colors.purple,
      actions: [
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: "add",
              child: Row(children: [Icon(Icons.add), Text("add")]),
            ),
            PopupMenuItem(
              value: "edit",
              child: Row(children: [Icon(Icons.edit), Text("edit")]),
            ),
            PopupMenuItem(
              value: "delete",
              child: Row(children: [Icon(Icons.delete), Text("delete")]),
            ),
          ],
          onSelected: (value) {
            IconData icon;
            String text;
            switch (value) {
              case "add":
                icon = Icons.add;
                text = "Add";
                break;
              case "edit":
                icon = Icons.edit;
                text = "edit";
                break;
              case "delete":
                icon = Icons.delete;
                text = "delete";
                break;
              default:
                icon = Icons.help;
                text = "unknown";
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(icon, size: 20),
                    SizedBox(width: 15),
                    Text("$text button is clicked."),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class PracticeDrawer extends StatelessWidget {
  final BuildContext context;
  const PracticeDrawer({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Hello"),
            accountEmail: Text("hello@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/img5.jpeg"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text("Home"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
