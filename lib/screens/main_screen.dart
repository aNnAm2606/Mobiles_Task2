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
        actions: [
          IconButton(
            icon: const Icon(Icons.donut_small),
            onPressed: (() {
              Navigator.pushNamed(context, '/about');
            }
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          newButtonDesign(context, 'todo', 'Favourite F'),
          separation(),
          newButtonDesign(context, 'tryings', 'tryings'),
          separation(),
          newButtonDesign(context, 'todo', 'Favourite Food'),
        ],
      ),
    );
  }

  SizedBox separation() {
    return const SizedBox(
      height: 10,
      width: 400,
    );
  }

  SizedBox newButtonDesign(
      BuildContext context, String screen, String buttonName) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/$screen');
        },
        child: Text(buttonName),
      ),
    );
  }
}
