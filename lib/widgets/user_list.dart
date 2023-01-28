// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../services/info.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Info?>?>(context) ?? [];
    //print(users.docs);
    if (users != null) {
      for (var user in users) {
        if (kDebugMode) {
          print(user!.name);
          print(user.gender);
          print(user.height);
          print(user.weight);
        }
      }

      return ListView.builder(
        itemCount: users.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Card(
              margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.redAccent,
                ),
                title: Text(users[index]?.name?? 'No User Name'),
                subtitle: Text(
                    '${users[index]!.gender}, ${users[index]!.weight} kg, ${users[index]!.height} cm'),
              ),
            ),
          );
        }),
      );
    } else {
      return const Center(
        child: SpinKitChasingDots(
          color: Colors.red,
          size: 50.0,
        ),
      );
    }
  }
}
