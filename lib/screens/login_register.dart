import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          child: const Align(
            child: Text(
              'FoodIZGood',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 255, 99, 64)),
            ),
          ),
        ),
      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obscure) {
      return Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white30),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white54, width: 1),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: IconTheme(
                  data: IconThemeData(
                      color: const Color.fromARGB(255, 255, 99, 64)),
                  child: icon),
            ),
          ),
        ),
      );
    }

    Widget _button(String text, void func()) {
      return ElevatedButton(
        onPressed: () {
          func();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.red, // background
          onPrimary: Colors.white, // foreground
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      );
    }

    ;

    Widget _form(String label, void func()) {
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: _input(
                Icon(Icons.email),
                'EMAIL',
                _emailController,
                false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: _input(
                Icon(Icons.lock),
                'PASSWORD',
                _passwordController,
                true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, func),
              ),
            )
          ],
        ),
      );
    }

    void _buttonAction() {
      _email = _emailController.text;
      _password = _passwordController.text;

      _emailController.clear();
      _passwordController.clear();
    }

    Widget _bottomWave() {
      return Expanded(
        child: Align(
          child: ClipPath(
            child: Container(
              color: Colors.white,
              height: 300,
            ),
            clipper: BottomWaveClipper(),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: Column(
          children: <Widget>[
            _logo(),
            (showLogin
                ? Column(
                    children: [
                      _form(
                        'LOGIN',
                        _buttonAction,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Text(
                            'Not registered yet? Register',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onTap: (() {
                            setState(() {
                              showLogin = false;
                            });
                          }),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      _form(
                        'REGISTER',
                        _buttonAction,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Text(
                            'ALready registered? Login',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onTap: (() {
                            setState(() {
                              showLogin = true;
                            });
                          }),
                        ),
                      ),
                    ],
                  )),
            _bottomWave(),
          ],
        ));
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
