import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_data');

  Future updateUserData(String name, String gender, var weight) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'gender': gender,
      'weight': weight,
    });
  }
}
