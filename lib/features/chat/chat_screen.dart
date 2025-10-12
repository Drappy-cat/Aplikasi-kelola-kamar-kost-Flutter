import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String recipientUserId;

  const ChatScreen({
    Key? key,
    required this.recipientUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with User $recipientUserId'),
      ),
      body: Center(
        child: Text('This is the chat screen for user $recipientUserId.'),
      ),
    );
  }
}
