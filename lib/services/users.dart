import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  String? uid;

  AuthUser.fromFirebase(User? user) {
    uid = user!.uid;
  }
}
