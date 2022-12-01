import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text('Task 2'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          const Text(
            'Main Screen',
            style: TextStyle(color: Colors.white),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/todo');
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
