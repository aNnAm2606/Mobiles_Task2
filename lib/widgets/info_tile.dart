import 'package:flutter/material.dart';
import 'package:deliverabl1task_2/services/info.dart';

class InfoTile extends StatelessWidget {
  final Info user;
  const InfoTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.redAccent,
          ),
          title: Text(user.name),
          subtitle: Text('${user.weight} kg, ${user.height} cm'),
        ),
      ),
    );
  }
}
