import 'package:flutter/material.dart';

class RoomChatPage extends StatelessWidget {
  const RoomChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RoomChatPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RoomChatPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
