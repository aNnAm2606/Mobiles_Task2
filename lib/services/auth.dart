import 'package:deliverabl1task_2/services/database.dart';
import 'package:deliverabl1task_2/services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'users.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  //create user object based on FirebaseUser
  NowUser? _userFromFirebaseUser(User user) {
    return user != null ? NowUser(uid: user.uid) : null;
  }

  Stream<NowUser> get user {
    return _fAuth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!)!);
  }

  Future<NowUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } on FirebaseException catch (error) {
      // ignore: avoid_print
      print(error);
      return null;
    }
  }

  Future<AuthUser?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      //create a new document for the user with the uid
      await DatabaseService(uid: user?.uid)
          .updateUserData('new member', '0', 0, 0);
      return AuthUser.fromFirebase(user!);
    } on FirebaseException catch (error) {
      // ignore: avoid_print
      print(error);
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<AuthUser?> get currentUser {
    return _fAuth
        .authStateChanges()
        .map((User? user) => user != null ? AuthUser.fromFirebase(user) : null);
  }
}
