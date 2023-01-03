import 'package:flutter/material.dart';

class DayScreen extends StatelessWidget {
  DayScreen({super.key});
  final DateTime day = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar:
          AppBar(title: Text("${day.day}/${day.month}/${day.year}"), actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/');
          },
          child: const Icon(Icons.login),
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: const Text('Breakfast'),
              textColor: Colors.white,
              tileColor: Colors.orangeAccent,
              selectedTileColor: const Color.fromARGB(255, 255, 99, 64),
              trailing: IconButton(
                onPressed: () {
                  //setState(() {});
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            ListTile(
              title: const Text('Lunch'),
              textColor: Colors.white,
              tileColor: Colors.orangeAccent,
              selectedTileColor: const Color.fromARGB(255, 255, 99, 64),
              trailing: IconButton(
                onPressed: () {
                  //setState(() {});
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            ListTile(
              title: const Text('Dinner'),
              textColor: Colors.white,
              tileColor: Colors.orangeAccent,
              selectedTileColor: const Color.fromARGB(255, 255, 99, 64),
              trailing: IconButton(
                onPressed: () {
                  //setState(() {});
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            ListTile(
              title: const Text('Snacks'),
              textColor: Colors.white,
              tileColor: Colors.orangeAccent,
              selectedTileColor: const Color.fromARGB(255, 255, 99, 64),
              trailing: IconButton(
                onPressed: () {
                  //setState(() {});
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.calendar_month),
        onPressed: () {
          showcalendar(context).then(
            (value) {},
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
