import 'package:flutter/material.dart';

class RoomCreatePage extends StatelessWidget {
  const RoomCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RoomCreatePage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RoomCreatePage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
