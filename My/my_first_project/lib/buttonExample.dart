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
      theme: ThemeData(primarySwatch: Colors.green),
      darkTheme: ThemeData(primarySwatch: Colors.amber),
      title: 'Common AppBar Demo',
      home: ButtonDemoPage(),
    );
  }
}

class ButtonDemoPage extends StatelessWidget {
  const ButtonDemoPage({super.key});
  void showMessage(String msg) {
    Fluttertoast.showToast(
      msg: "This is a Toast! $msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Buttons Demo.")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showMessage("FloatingActionButton  clicked."),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                showMessage("ElevatedButton Clicked.");
              },
              child: const Text("Elevated Button"),
            ),

            const SizedBox(height: 10),

            /// SNACKBAR
            TextButton(
              onPressed: () {
                showMessage("TextButton clicked");
              },
              child: const Text("Text Button"),
            ),
            const SizedBox(height: 10),

            /// ALERT DIALOG
            OutlinedButton(
              onPressed: () {
                showMessage("OutlinedButton clicked");
              },
              child: const Text("OutlinedButton"),
            ),
            const SizedBox(height: 10),

            IconButton(
              onPressed: () {
                showMessage("IconButton clicked");
              },
              icon: Icon(Icons.settings),
            ),

            MaterialButton(
              onPressed: () {
                showMessage("MaterialButton clicked");
              },
              child: const Text("Material Button"),
            ),
            const SizedBox(height: 10),

            InkWell(
              onTap: () => showMessage("Custom InkWell Button clicked"),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Custom InkWell Button",
                    style: TextStyle(color: Colors.white),
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
