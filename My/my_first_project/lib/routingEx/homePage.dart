import 'package:flutter/material.dart';
import 'package:my_first_project/routingEx/ProfilePage.dart';
import 'package:my_first_project/routingEx/aboutPage.dart';
import 'package:my_first_project/routingEx/contactPage.dart';
import 'package:my_first_project/routingEx/inputPage.dart';
import 'package:my_first_project/routingEx/messagePage.dart';


// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.pop(context),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1️⃣ Basic push/pop
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: const Text("Go to Profile (push)"),
            ),
            const SizedBox(height: 10),

            // 2️⃣ Named route
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
              child: const Text("Go to About (named route)"),
            ),
            const SizedBox(height: 10),

            // 3️⃣ Passing data to next page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MessagePage(message: "Hello from Home!"),
                  ),
                );
              },
              child: const Text("Pass Data to Message Page"),
            ),
            const SizedBox(height: 10),

            // 4️⃣ Receiving data back from next page
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InputPage()),
                );
                if (result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("You entered: $result")),
                  );
                }
              },
              child: const Text("Get Data from Input Page"),
            ),
            const SizedBox(height: 10),

            // 5️⃣ Replace current page
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Aboutpage()),
                );
              },
              child: const Text("Replace with About Page"),
            ),
            const SizedBox(height: 10),

            // 6️⃣ Remove all previous pages and go to Contact
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactPage()),
                  (route) => false,
                );
              },
              child: const Text("Go to Contact (clear stack)"),
            ),
          ],
        ),
      ),
    );
  }
}