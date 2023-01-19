import 'package:deliverabl1task_2/firebase_options.dart';
import 'package:deliverabl1task_2/screens/about_screen.dart';
import 'package:deliverabl1task_2/screens/day_screen.dart';
import 'package:deliverabl1task_2/screens/dish_screen.dart';
import 'package:deliverabl1task_2/screens/loading.dart';
import 'package:deliverabl1task_2/screens/main_screen.dart';
import 'package:deliverabl1task_2/screens/favourite_food.dart';
import 'package:deliverabl1task_2/screens/login_register.dart';
import 'package:deliverabl1task_2/screens/loading.dart';
import 'package:deliverabl1task_2/services/auth.dart';
import 'package:deliverabl1task_2/services/users.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthUser?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoadingPage(),
          //const MainScreen(),
          '/todo': (context) => const FavouriteFood(),
          '/tryings': (context) => DishScreen(),
          '/about': (context) => const About(),
          '/day': (context) => DayScreen(),
          '/login': (context) => AuthorizationPage(),
        },
      ),
    );
  }
}
