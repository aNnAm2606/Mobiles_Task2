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
  var bContainerHeight = 0.0;
  var lContainerHeight = 0.0;
  var dContainerHeight = 0.0;
  var sContainerHeight = 0.0;
  var bColor = Colors.white;
  var lColor = Colors.white;
  var dColor = Colors.white;
  var sColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    var curvedNavigationBar = CurvedNavigationBar(
      items: [
        IconButton(
          icon: const Icon(
            Icons.calendar_month,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/main');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.edit_calendar,
          ),
          color: Colors.white,
          onPressed: () {},
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
      index: 1,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    setState(() {
                      bContainerHeight =
                          (bContainerHeight == 0.0 ? 100.0 : 0.0);
                    });
                  },
                  title: const Text('Breakfast'),
                  textColor: Colors.white,
                  tileColor: Colors.red,
                  selectedTileColor: const Color.fromARGB(255, 255, 99, 64),
                  trailing: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          bColor = (bColor == Colors.white
                              ? const Color.fromARGB(255, 54, 52, 52)
                              : Colors.white);
                        },
                      );
                    },
                    icon: Icon(
                      Icons.breakfast_dining,
                      color: bColor,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 7,
                  ),
                  child: const Card(),
                  height: bContainerHeight,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                ListTile(
                  onTap: () {
                    setState(
                      () {
                        lContainerHeight =
                            (lContainerHeight == 0.0 ? 100.0 : 0.0);
                      },
                    );
                  },
                  title: const Text('Lunch'),
                  textColor: Colors.white,
                  tileColor: Colors.red,
                  selectedTileColor: const Color.fromARGB(255, 255, 99, 64),
                  trailing: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          lColor = (lColor == Colors.white
                              ? const Color.fromARGB(255, 54, 52, 52)
                              : Colors.white);
                        },
                      );
                    },
                    icon: Icon(
                      Icons.lunch_dining,
                      color: lColor,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 7,
                  ),
                  child: const Card(),
                  height: lContainerHeight,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                ListTile(
                  onTap: () {
                    setState(
                      () {
                        dContainerHeight =
                            (dContainerHeight == 0.0 ? 100.0 : 0.0);
                      },
                    );
                  },
                  title: const Text('Dinner'),
                  textColor: Colors.white,
                  tileColor: Colors.red,
                  selectedTileColor: const Color.fromARGB(255, 255, 99, 64),
                  trailing: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          dColor = (dColor == Colors.white
                              ? const Color.fromARGB(255, 54, 52, 52)
                              : Colors.white);
                        },
                      );
                    },
                    icon: Icon(
                      Icons.dinner_dining,
                      color: dColor,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 7,
                  ),
                  child: const Card(
                    color: Colors.white,
                  ),
                  height: dContainerHeight,
                  curve: Curves.fastOutSlowIn,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                ListTile(
                  onTap: () {
                    setState(
                      () {
                        sContainerHeight =
                            (sContainerHeight == 0.0 ? 100.0 : 0.0);
                      },
                    );
                  },
                  title: const Text('Snacks'),
                  textColor: Colors.white,
                  tileColor: Colors.red,
                  selectedTileColor: const Color.fromARGB(255, 255, 99, 64),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        sColor = (sColor == Colors.white
                            ? const Color.fromARGB(255, 54, 52, 52)
                            : Colors.white);
                      });
                    },
                    icon: Icon(
                      Icons.free_breakfast,
                      color: sColor,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 7,
                  ),
                  child: const Card(),
                  height: bContainerHeight,
                ),
              ],
            ),
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
