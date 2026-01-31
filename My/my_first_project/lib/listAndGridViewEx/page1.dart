import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text("List title 1"),
          subtitle: Text("ListTitle practice with flutter"),
          leading: CircleAvatar(child: Icon(Icons.add_call)),
          trailing: Icon(Icons.account_circle),
        ),
        ListTile(
          title: Text("List title 1"),
          subtitle: Text("ListTitle practice with flutter"),
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/img5.jpeg"),
          ),
          // trailing: Image.asset("assets/img7.jpeg"),
          trailing: Container(
            height: 50,
            width: 50,
            child: ClipOval(
              child: Image.asset("assets/img7.jpeg", fit: BoxFit.cover),
            ),
          ),
        ),
        ListTile(
          title: Text("List title 1"),
          subtitle: Text("ListTitle practice with flutter"),
          leading: CircleAvatar(child: Icon(Icons.add_call)),
          trailing: Icon(Icons.account_circle),
        ),
        ListTile(
          title: Text("List title 1"),
          subtitle: Text("ListTitle practice with flutter"),
          leading: CircleAvatar(child: Icon(Icons.add_call)),
          trailing: Icon(Icons.account_circle),
        ),
        ListTile(
          title: Text("List title 1"),
          subtitle: Text("ListTitle practice with flutter"),
          leading: CircleAvatar(child: Icon(Icons.add_call)),
          trailing: Icon(Icons.account_circle),
        ),
        ListTile(
          title: Text("List title 1"),
          subtitle: Text("ListTitle practice with flutter"),
          leading: CircleAvatar(child: Icon(Icons.add_call)),
          trailing: Icon(Icons.account_circle),
        ),
        ListTile(
          title: Text("List title 1"),
          subtitle: Text("ListTitle practice with flutter"),
          leading: CircleAvatar(child: Icon(Icons.add_call)),
          trailing: Icon(Icons.account_circle),
        ),
        ListTile(
          title: Text("List title 1"),
          subtitle: Text("ListTitle practice with flutter"),
          leading: CircleAvatar(child: Icon(Icons.add_call)),
          trailing: Icon(Icons.account_circle),
        ),
        ListTile(
          title: Text("List title 1"),
          subtitle: Text("ListTitle practice with flutter"),
          leading: CircleAvatar(child: Icon(Icons.add_call)),
          trailing: Icon(Icons.account_circle),
        ),
        ListTile(
          title: Text("List title 1"),
          subtitle: Text("ListTitle practice with flutter"),
          leading: CircleAvatar(child: Icon(Icons.add_call)),
          trailing: Icon(Icons.account_circle),
        ),
        ListTile(
          title: Text("List title 1"),
          subtitle: Text("ListTitle practice with flutter"),
          leading: CircleAvatar(child: Icon(Icons.add_call)),
          trailing: Icon(Icons.account_circle),
        ),
        ListTile(
          title: Text("List title 1"),
          subtitle: Text("ListTitle practice with flutter"),
          leading: CircleAvatar(child: Icon(Icons.add_call)),
          trailing: Icon(Icons.account_circle),
        ),
      ],
    );
  }
}
