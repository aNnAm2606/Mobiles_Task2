import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverabl1task_2/services/info.dart';
import 'package:deliverabl1task_2/services/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_data');

  Future updateUserData(
      String name, String gender, var height, var weight) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'gender': gender,
      'height': height,
      'weight': weight,
    });
  }

  //info list from snapshot
  List<Info?>? _infoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Info(
        name: doc.get('name') ?? "",
        gender: doc.get('gender') ?? "a...",
        height: doc.get('height') ?? 0,
        weight: doc.get('weight') ?? 0,
      );
    }).toList();
  }

  //User data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid!,
      name: snapshot.get('name'),
      gender: snapshot.get('gender'),
      height: snapshot.get('height'),
      weight: snapshot.get('weight'),
    );
  }

  //Get users stream
  Stream<List<Info?>?> get users {
    return userCollection.snapshots().map(_infoListFromSnapshot);
  }

  //Get the user doc stream
  Stream<UserData?> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}
