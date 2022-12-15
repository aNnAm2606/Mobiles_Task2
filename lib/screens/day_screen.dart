import 'package:flutter/material.dart';

class DayScreen extends StatelessWidget {
  DayScreen({super.key});
  final DateTime day = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About"), actions: [
        ElevatedButton(
          onPressed: (){
            Navigator.of(context).pushNamed('/');
          },
          child: const Icon(Icons.login),
        )
      ]),
      body: Row(
        children: [
          Text('${day.day}/'),
          Text('${day.month}/'),
          Text('${day.year}'),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.calendar_month),
        
        onPressed: () {
          showcalendar(context).then(
            (value) {
            },
          );
        },
      ),
    );
  }
}

Future<DateTime?> showcalendar(BuildContext con) {
  return showDatePicker(
    context: con,
    initialDate: DateTime.now(),
    firstDate: DateTime.utc(2022),
    lastDate: DateTime.utc(2023, 12, 31),
  );
}
