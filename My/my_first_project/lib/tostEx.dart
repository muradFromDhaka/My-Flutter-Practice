import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Popup Examples"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(value: 1, child: Text("Add")),
              PopupMenuItem(value: 2, child: Icon(Icons.delete, size: 18)),
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 18),
                    SizedBox(width: 8),
                    Text('Edit'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.edit, size: 18),
                      SizedBox(width: 8),
                      Text("Selected option: $value"),
                    ],
                  ),
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green, // Set your desired color here
                  content: Row(
                    children: [
                      const Icon(Icons.edit, size: 18, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        "Selected option: $value",
                        style: const TextStyle(color: Colors.white), // optional
                      ),
                    ],
                  ),
                  duration: const Duration(seconds: 2), // optional
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              print("Button 2 Clicked");
            },
            icon: Icon(Icons.dangerous_sharp),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// TOAST
            ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "This is a Toast message",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              },
              child: const Text("Show Toast"),
            ),

            /// SNACKBAR
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("This is a Snackbar")),
                );
              },
              child: const Text("Show Snackbar"),
            ),

            /// ALERT DIALOG
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Alert"),
                    content: const Text("This is an alert dialog"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Show Alert Dialog"),
            ),

            /// CONFIRMATION DIALOG
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Confirm"),
                    content: const Text("Are you sure?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
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
              child: const Text("Show Confirmation Dialog"),
            ),

            /// MODAL BOTTOM SHEET
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Modal Bottom Sheet",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Close"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text("Show Modal Bottom Sheet"),
            ),

            /// LOADING DIALOG
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );

                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pop(context);
                });
              },
              child: const Text("Show Loading Dialog"),
            ),
          ],
        ),
      ),
    );
  }
}
