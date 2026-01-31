import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      darkTheme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("e-commerce app"),
        titleSpacing: 20,
        toolbarHeight: 60,
        toolbarOpacity: 1,
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            onPressed: () {
              Fluttertoast.showToast(
                msg: "This is a toast message",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            },
            icon: const Icon(Icons.search, size: 30),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.dashboard, size: 30),
                      SizedBox(width: 10),
                      Text("Dashboard"),
                    ],
                  ),
                  backgroundColor: Colors.teal,
                ),
              );
            },
            icon: const Icon(Icons.dashboard, size: 30),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("This is a settings message.")),
              );
            },
            icon: const Icon(Icons.settings, size: 30),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "brand",
                child: Row(
                  children: const [
                    Icon(Icons.branding_watermark, size: 25),
                    SizedBox(width: 10),
                    Text("Brand"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "category",
                child: Row(
                  children: const [
                    Icon(Icons.category, size: 25),
                    SizedBox(width: 10),
                    Text("Category"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "products",
                child: Row(
                  children: const [
                    Icon(Icons.production_quantity_limits, size: 25),
                    SizedBox(width: 10),
                    Text("Products"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "inventory",
                child: Row(
                  children: const [
                    Icon(Icons.inventory, size: 25),
                    SizedBox(width: 10),
                    Text("Inventory"),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              IconData icon;

              // Switch-case with proper break and fallback
              switch (value) {
                case 'brand':
                  icon = Icons.branding_watermark;
                  break;
                case 'category':
                  icon = Icons.category;
                  break;
                case 'products':
                  icon = Icons.production_quantity_limits;
                  break;
                case 'inventory':
                  icon = Icons.inventory;
                  break;
                default:
                  icon = Icons.help; // fallback icon
                  print("Unknown value");
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(icon, size: 25),
                      const SizedBox(width: 10),
                      Text("$value clicked."),
                    ],
                  ),
                  backgroundColor: Colors.greenAccent,
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Toast
            ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "This a toast message.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(244, 106, 2, 241),
              ),
              child: Text(
                "show Toast",
                style: TextStyle(
                  color: const Color.fromARGB(255, 246, 244, 247),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //Snackbar
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("This is a snackbar message."),
                    backgroundColor: const Color.fromARGB(255, 226, 9, 118),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(233, 17, 38, 231),
              ),
              child: const Text(
                "Show Snackbar",
                style: TextStyle(
                  color: Color.fromARGB(222, 9, 211, 70),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("alert"),
                    content: const Text("This is an alert dialog message."),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("No"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(244, 225, 0, 255),
              ),
              child: Text(
                "show AlertDialog",
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 204, 255),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Show Modal Bottom Sheet"),
                        SizedBox(width: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("No"),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Yes"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(244, 143, 111, 231),
              ),
              child: Text(
                "show Modal Bottom Sheet",
                style: TextStyle(
                  color: const Color.fromARGB(255, 66, 227, 233),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pop(context);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(244, 183, 154, 221),
              ),
              child: Text(
                "Show Loading",
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
