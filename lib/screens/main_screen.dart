import 'package:deliverabl1task_2/services/auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text(
          'FoodIZGood',
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 80, 64),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: (() {
              Navigator.pushNamed(context, '/about');
            }),
          ),
          IconButton(
              color: Colors.white,
              onPressed: (() {
                AuthService().logOut();
              }),
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          newButtonDesign(context, 'day', 'Meal Diary'),
          separation(),
          newButtonDesign(context, 'tryings', 'Recipes'),
          separation(),
          newButtonDesign(context, 'todo', 'Favourite Food'),
          separation(),
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
        child: Text(
          buttonName,
        ),
      ),
    );
  }
}
