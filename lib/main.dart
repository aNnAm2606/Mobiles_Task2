import 'package:deliverabl1task_2/screens/main_screen.dart';
import 'package:deliverabl1task_2/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      color: Colors.orangeAccent,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/todo': (context) => Home(),
      },
    ),
  );
}
