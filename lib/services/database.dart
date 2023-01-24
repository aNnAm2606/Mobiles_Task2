import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverabl1task_2/services/info.dart';

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
  List<Info>? _infoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Info(
        name: doc.get('name') ?? " ",
        gender: doc.get('gender') ?? " ",
        height: doc.get('height') ?? " ",
        weight: doc.get('weight') ?? "",
      );
    }).toList();
  }

  //Get users stream
  Stream<List<Info?>?> get users {
    return userCollection.snapshots().map(_infoListFromSnapshot);
  }
}
