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
      theme: ThemeData(primarySwatch: Colors.amber),
      darkTheme: ThemeData(primarySwatch: Colors.deepOrange),
      home: practice8(),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.green,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      titleSpacing: 20,
      toolbarHeight: 60,
      toolbarOpacity: 1,
      backgroundColor: Colors.deepPurple,
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 25)),
        IconButton(onPressed: () {}, icon: Icon(Icons.settings, size: 25)),
        IconButton(onPressed: () {}, icon: Icon(Icons.dashboard, size: 25)),
      ],
    );
  }
}

class Practice1 extends StatelessWidget {
  const Practice1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Flutter App"),
        titleSpacing: 15,
        toolbarHeight: 60,
        backgroundColor: Colors.deepPurple,
        actions: [
          // 🔍 Search
          IconButton(
            icon: const Icon(Icons.search, size: 25),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Row(
                    children: [
                      Icon(Icons.search, size: 25),
                      SizedBox(width: 10),
                      Text("Search button is clicked"),
                    ],
                  ),
                ),
              );
            },
          ),

          // ⚙ AlertDialog
          IconButton(
            icon: const Icon(Icons.settings, size: 25),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Alert"),
                    content: const Text("This is an alert dialog message"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("No"),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          // 📦 Toast
          IconButton(
            icon: const Icon(Icons.dashboard, size: 25),
            onPressed: () {
              Fluttertoast.showToast(
                msg: "This is a toast message",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            },
          ),

          // ⬆ Bottom Sheet
          IconButton(
            icon: const Icon(Icons.house, size: 25),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "This is a modal bottom sheet",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Yes"),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("No"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          // ☰ Popup Menu
          PopupMenuButton<String>(
            onSelected: (value) {
              late IconData icon;
              late String text;

              switch (value) {
                case "add":
                  icon = Icons.add;
                  text = "Add";
                  break;
                case "edit":
                  icon = Icons.edit;
                  text = "Edit";
                  break;
                case "delete":
                  icon = Icons.delete;
                  text = "Delete";
                  break;
                case "settings":
                  icon = Icons.settings;
                  text = "Settings";
                  break;
                case "logout":
                  icon = Icons.logout;
                  text = "Logout";
                  break;
                default:
                  icon = Icons.help;
                  text = "Unknown";
              }

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        Icon(icon),
                        const SizedBox(width: 8),
                        const Text("Alert"),
                      ],
                    ),
                    content: Text("$text button is clicked."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            },
            itemBuilder: (context) => [
              popupItem("add", Icons.add),
              popupItem("edit", Icons.edit),
              popupItem("delete", Icons.delete),
              popupItem("settings", Icons.settings),
              popupItem("logout", Icons.logout),
            ],
          ),
        ],
      ),

      // ✅ BODY: horizontal scrollable Row
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _coloredBox(Colors.amber, "Widget 1"),
            _coloredBox(const Color.fromARGB(255, 184, 250, 2), "Widget 2"),
            _coloredBox(const Color.fromARGB(255, 0, 247, 255), "Widget 3"),
            _coloredBox(const Color.fromARGB(255, 183, 0, 255), "Widget 4"),
            _coloredBox(const Color.fromARGB(255, 255, 128, 0), "Widget 5"),
            _coloredBox(const Color.fromARGB(255, 128, 0, 255), "Widget 6"),
          ],
        ),
      ),
    );
  }

  // ✅ Helper for PopupMenu
  PopupMenuItem<String> popupItem(String value, IconData icon) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [Icon(icon), const SizedBox(width: 10), Text(value)],
      ),
    );
  }

  // ✅ Helper for Colored Boxes
  Widget _coloredBox(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 200,
        color: color,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class practice2 extends StatelessWidget {
  const practice2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(30),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 248, 3, 3),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 241, 1, 1),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 224, 9, 9),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 209, 8, 8),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 248, 3, 3),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 241, 1, 1),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 224, 9, 9),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 209, 8, 8),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 248, 3, 3),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 241, 1, 1),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 224, 9, 9),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 209, 8, 8),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class practice3 extends StatelessWidget {
  const practice3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Practice---3"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.green,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text(
                      "Reading is one of the most powerful habits a person can develop. It opens the door to knowledge, imagination, and critical thinking. Through books, people can explore different cultures, understand new ideas, and experience adventures beyond their own lives. Reading also improves language skills, concentration, and empathy, helping individuals communicate and connect better with others. In a world full of distractions, taking time to read allows the mind to grow, reflect, and stay sharp. Ultimately, reading is not just a pastime—it is a lifelong tool for personal and intellectual growth.Reading is one of the most powerful habits a person can develop. It opens the door to knowledge, imagination, and critical thinking. Through books, people can explore different cultures, understand new ideas, and experience adventures beyond their own lives. Reading also improves language skills, concentration, and empathy, helping individuals communicate and co",
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 300,
              width: double.infinity,
              margin: EdgeInsets.all(12),
              // color: const Color.fromARGB(255, 255, 254, 254),
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 12, 3, 2)),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.purple,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.purple,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.purple,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.purple,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.purple,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.purple,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: double.infinity,
                      width: 200,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      "slfksdfjosdfsdfjsdflsd sdlfjsdkfsdlfjsd lsdfjksdfsdlkflsd  lkdfsdfsdlsfselk lkdsjflsj ",
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.red,
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.purple,
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.blue,
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.green,
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.red,
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.purple,
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.blue,
                ),
                SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class practice4 extends StatelessWidget {
  const practice4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Practice- 4"),
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(height: 300, width: 200, color: Colors.red),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 300,
              width: 200,
              color: const Color.fromARGB(255, 177, 116, 112),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 300,
              width: 200,
              color: const Color.fromARGB(255, 0, 231, 231),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 300,
              width: 200,
              color: const Color.fromARGB(255, 255, 0, 242),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 300,
              width: 200,
              color: const Color.fromARGB(255, 0, 183, 255),
            ),
          ),
        ],
      ),
    );
  }
}

class practice5 extends StatelessWidget {
  const practice5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Practice 5"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(height: 200, width: double.infinity, color: Colors.green),
            Container(
              height: 200,
              width: double.infinity,
              color: const Color.fromARGB(255, 255, 1, 13),
            ),
            Container(
              height: 200,
              width: double.infinity,
              // color: const Color.fromARGB(255, 132, 4, 236),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Hello clicked")));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.house, size: 30),
                        SizedBox(width: 10),
                        Text("Hello"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.only(top: 12, bottom: 12),
              color: const Color.fromARGB(255, 212, 0, 255),
            ),
            Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.only(top: 12, bottom: 12),
              color: const Color.fromARGB(255, 5, 63, 255),
            ),
            Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.only(top: 12, bottom: 12),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class practice7 extends StatelessWidget {
  const practice7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Practice 7"),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: double.infinity,
                color: Colors.green,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: double.infinity,
                color: const Color.fromARGB(255, 76, 78, 175),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Container(
                height: 200,
                width: double.infinity,
                color: const Color.fromARGB(255, 255, 5, 222),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4, right: 3),
              child: Container(
                height: 200,
                width: double.infinity,
                color: const Color.fromARGB(255, 47, 0, 255),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.green,
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Container(
                height: 200,
                width: double.infinity,
                color: const Color.fromARGB(255, 76, 78, 175),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Container(
                height: 200,
                width: double.infinity,
                color: const Color.fromARGB(255, 0, 250, 125),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 200,
              width: double.infinity,
              color: const Color.fromARGB(255, 255, 1, 234),
            ),
          ),
        ],
      ),
    );
  }
}

class practice8 extends StatelessWidget {
  const practice8({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Practice 8"),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  height: 300,
                  width: 300,
                  child: Image.network(
                    "https://1worldsync.com/wp-content/uploads/2024/02/beauty-photography-trends-2024-FI-683x1024.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS65sfDUyun306a4Vy93t0IGjnJ1yfKJ2eL4Q&s",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  // color: Colors.green,
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoyJfQ2k0Lr6SgD86RNTSU53x0U-d32M8Isw&s",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Exercise extends StatelessWidget {
  const Exercise({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: MyAppBar(title: "Exercise app"));
  }
}
