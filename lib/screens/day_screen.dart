import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class DayScreen extends StatefulWidget {
  DayScreen({super.key});

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  final DateTime day = DateTime.now();
  int sectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    var curvedNavigationBar = CurvedNavigationBar(
      items: [
        IconButton(
          icon: const Icon(
            Icons.edit_calendar,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/day');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.search,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/tryings');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.star,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/favourite');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.info,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/about');
          },
        ),
      ],
      index: 0,
      height: 50,
      color: Colors.white.withOpacity(0.5),
      buttonBackgroundColor: Colors.red,
      backgroundColor: const Color.fromARGB(255, 52, 49, 49),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
      onTap: (int index) {
        setState(() => sectionIndex = index);
      },
    );
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          title: Text("${day.day}/${day.month}/${day.year}"),
          actions: [
            IconButton(
                color: Colors.white,
                onPressed: (() {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                }),
                icon: const Icon(Icons.home))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                title: const Text('Breakfast'),
                textColor: Colors.white,
                tileColor: Colors.red,
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
                tileColor: Colors.red,
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
                tileColor: Colors.red,
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
                tileColor: Colors.red,
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
        bottomNavigationBar: curvedNavigationBar);
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
