import 'package:flutter/material.dart';

class RoomFilterPage extends StatelessWidget {
  const RoomFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RoomFilterPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RoomFilterPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
