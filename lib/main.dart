
import 'package:deliverabl1task_2/screens/dish_screen.dart';
import 'package:deliverabl1task_2/screens/main_screen.dart';
import 'package:deliverabl1task_2/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/todo': (context) => const Home(),
        '/tryings': (context) => const DishScreen(),
      },
    ),
  );
}
