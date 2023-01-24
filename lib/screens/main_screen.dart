import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:deliverabl1task_2/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:deliverabl1task_2/services/database.dart';
import 'package:provider/provider.dart';

import '../services/info.dart';
import '../widgets/user_list.dart';

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
            Icons.home,
          ),
          color: Colors.white,
          onPressed: () {},
        ),
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
    return StreamProvider<List<Info?>?>.value(
      initialData: null,
      value: DatabaseService(uid: '').users,
      child: Scaffold(
          backgroundColor: Colors.grey[800],
          appBar: AppBar(
            title: const Text(
              'FoodIZGood',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
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
          body: UserList(),
          /* Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 70),
                  child: newButtonDesign(context, 'day', 'Meal Diary'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                  child: newButtonDesign(context, 'tryings', 'Recipes'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                  child:
                      newButtonDesign(context, 'favourite', 'Favourite Food'),
                ),
              ],
            ),
          ), */
          bottomNavigationBar: curvedNavigationBar),
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
