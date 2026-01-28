
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
      home: DrawerEx(),
      // initialRoute: "/p1",
      //  initialRoute: (token != null && JwtDecoder.isExpired(token) == false )?"/dash":"/login",
      // routes: {
      //   "/p1": (context) => Page1(),
      //   "/p2": (context) => Page2(),
      //   "/p3": (context) => Page3(),
      //   // "/login": (context) => LoginScreen(),
      //   // MainScreen.idScreen: (context) => MainScreen(),
      //   // ListPage.idScreen: (context) => ListPage(),
      // },
    );
  }
}




class DrawerEx extends StatelessWidget {
  const DrawerEx({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawer Example"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(child: Text("Welcome to Drawer Example")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
                "Hello Bangladesh",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                "helloBangladesh@gmail.com",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBSmhvi6o9QLkZAO9jS3_V_z9QFhAyFepxqA&s",
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text("Page 1"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("page 1 loaded successfully..!"),
                    duration: Duration(seconds: 2), // optional
                    backgroundColor: Colors.blue, // optional
                    action: SnackBarAction(
                      // optional
                      label: "Undo",
                      onPressed: () {
                        // undo code here
                      },
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text("Page 2"),
              onTap: () {
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar())
              },
            ),
          ],
        ),
      ),
    );
  }
}
