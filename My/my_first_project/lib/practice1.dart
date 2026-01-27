import 'package:flutter/material.dart';

void main() {
   
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("sunlight e-commerce"),
      titleSpacing: 15,
      toolbarHeight: 70,
      toolbarOpacity: 1,
      backgroundColor: Colors.purpleAccent,
      actions: [
        IconButton(
          onPressed: () {
            print("icon 1 clicked");
          },
          icon: Icon(Icons.search),
          iconSize: 30,
        ),
        IconButton(
          onPressed: () {
            print("icon 3 clicked");
          },
          icon: Icon(Icons.edit),
          iconSize: 30,
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
