import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MyPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
