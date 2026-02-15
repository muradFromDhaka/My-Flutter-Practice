import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  final String peerId;
  final String peerName;

  ChatScreen({required this.peerId, required this.peerName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final messageController = TextEditingController();

  String getChatId() {
    return currentUserId.hashCode <= widget.peerId.hashCode
        ? '$currentUserId-${widget.peerId}'
        : '${widget.peerId}-$currentUserId';
  }

  void sendMessage() {
    String msg = messageController.text.trim();
    if (msg.isEmpty) return;

    FirebaseFirestore.instance.collection('chats')
      .doc(getChatId())
      .collection('messages')
      .add({
        'senderId': currentUserId,
        'receiverId': widget.peerId,
        'message': msg,
        'timestamp': FieldValue.serverTimestamp(),
      });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.peerName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(getChatId())
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                var messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var msg = messages[index];
                    bool isMe = msg['senderId'] == currentUserId;
                    return Container(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(msg['message'], style: TextStyle(color: isMe ? Colors.white : Colors.black)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(controller: messageController, decoration: InputDecoration(hintText: "Type a message")),
                ),
                IconButton(icon: Icon(Icons.send), onPressed: sendMessage)
              ],
            ),
          )
        ],
      ),
    );
  }
}
