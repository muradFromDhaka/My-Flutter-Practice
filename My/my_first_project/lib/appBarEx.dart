import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void showMsg(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TITLE
        title: const Text("All-in-One AppBar"),
        centerTitle: true,

        // HEIGHT & STYLE
        toolbarHeight: 65,
        elevation: 8,

        // GRADIENT BACKGROUND
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
          ),
        ),

        // LEFT ICON
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            showMsg(context, "Menu clicked");
          },
        ),

        // RIGHT ACTIONS
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showMsg(context, "Search clicked");
            },
          ),

          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              showMsg(context, "Notifications clicked");
            },
          ),

          // POPUP MENU
          PopupMenuButton<String>(
            onSelected: (value) {
              showMsg(context, "$value selected");
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: "Profile", child: Text("Profile")),
              PopupMenuItem(value: "Settings", child: Text("Settings")),
              PopupMenuItem(value: "Logout", child: Text("Logout")),
            ],
          ),

          const SizedBox(width: 8),
        ],
      ),

      // BODY CONTENT
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "This page demonstrates:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("✔ Title"),
            Text("✔ Leading icon"),
            Text("✔ Action buttons"),
            Text("✔ Snackbar messages"),
            Text("✔ Popup menu"),
            Text("✔ Custom height"),
            Text("✔ Gradient AppBar"),
          ],
        ),
      ),
    );
  }
}
