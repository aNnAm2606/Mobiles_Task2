import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:deliverabl1task_2/services/auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int sectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    var curvedNavigationBar = CurvedNavigationBar(
      items: [
        IconButton(
          icon: const Icon(
            Icons.edit_calendar,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/day');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.search,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/tryings');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.star,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/favourite');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.info,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/about');
          },
        ),
      ],
      index: 0,
      height: 50,
      color: Colors.white.withOpacity(0.5),
      backgroundColor: const Color.fromARGB(255, 52, 49, 49),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
      onTap: (int index) {
        setState(() => sectionIndex = index);
      },
    );
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
        bottomNavigationBar: curvedNavigationBar);
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
