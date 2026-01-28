import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      home: BTNavigation(),
    );
  }
}

class BTNavigation extends StatefulWidget {
  const BTNavigation({super.key});

  @override
  State<BTNavigation> createState() => _BTNavigationState();
}

class _BTNavigationState extends State<BTNavigation> {
  int _currentIndex = 0;

  final pages = const [
    ChatsPage(),
    CallsPage(),
    StatusPage(),
  ];

  final appBars = [
    AppBar(
      title: const Text("Chats"),
      backgroundColor: Colors.green,
      actions: const [
        Icon(Icons.camera_alt),
        SizedBox(width: 15),
        Icon(Icons.search),
        SizedBox(width: 10),
        Icon(Icons.more_vert),
        SizedBox(width: 10),
      ],
    ),
    AppBar(
      title: const Text("Calls"),
      backgroundColor: Colors.green,
      actions: const [
        Icon(Icons.search),
        SizedBox(width: 10),
        Icon(Icons.more_vert),
        SizedBox(width: 10),
      ],
    ),
    AppBar(
      title: const Text("Status"),
      backgroundColor: Colors.green,
      actions: const [
        Icon(Icons.more_vert),
        SizedBox(width: 10),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars[_currentIndex],
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: "Calls",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: "Status",
          ),
        ],
      ),
    );
  }
}


class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text("Contact ${index + 1}"),
          subtitle: const Text("Last message preview..."),
          trailing: const Text("12:30 PM"),
        );
      },
    );
  }
}
class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.call, color: Colors.white),
          ),
          title: Text("Caller ${index + 1}"),
          subtitle: const Text("Yesterday, 10:45 PM"),
          trailing: const Icon(Icons.call, color: Colors.green),
        );
      },
    );
  }
}
class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.add, color: Colors.white),
          ),
          title: Text("My Status"),
          subtitle: Text("Tap to add status update"),
        ),
        const Divider(),
        ...List.generate(
          10,
          (index) => ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person),
            ),
            title: Text("Friend ${index + 1}"),
            subtitle: const Text("Today, 9:00 AM"),
          ),
        )
      ],
    );
  }
}
