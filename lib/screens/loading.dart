// ignore_for_file: implementation_imports

import 'package:deliverabl1task_2/screens/main_screen.dart';
import 'package:deliverabl1task_2/services/users.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:deliverabl1task_2/screens/login_register.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {

    AuthUser? user = Provider.of<AuthUser?>(context);
    final bool isLoggedIn = user != null;
    return isLoggedIn ? const MainScreen() : const AuthorizationPage();
  }
}
