import 'package:flutter/material.dart';

class RoomListPage extends StatelessWidget {
  const RoomListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RoomListPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RoomListPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
