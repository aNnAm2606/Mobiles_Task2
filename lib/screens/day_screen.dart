import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DayScreen extends StatefulWidget {
  const DayScreen({super.key});

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  final DateTime day = DateTime.now();
  int sectionIndex = 0;
  var bContainerHeight = 0.0;
  var lContainerHeight = 0.0;
  var dContainerHeight = 0.0;
  var bColor = Colors.white;
  var lColor = Colors.white;
  var dColor = Colors.white;

  String? _userKm;
  String? _userActivities;
  String? _userSleep;

  String? km = '0 km';
  String? activities = '';
  String? sleep = '';

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    var curvedNavigationBar = CurvedNavigationBar(
      items: [
        IconButton(
          icon: const Icon(
            Icons.home,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/',
              (route) => false,
            );
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
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/tryings',
              (route) => false,
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.star,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.restorablePushNamedAndRemoveUntil(
              context,
              '/favourite',
              (route) => false,
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.info,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/about',
              (route) => false,
            );
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
                  title: const Text('Steps / Km to walk today Goal'),
                  textColor: Colors.white,
                  tileColor: Colors.red,
                  selectedTileColor: const Color.fromARGB(255, 255, 99, 64),
                  trailing: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Add a distance walked'),
                                  content: TextField(
                                    onChanged: (String value) {
                                      _userKm = value;
                                    },
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('day_data')
                                            .add({'km': _userKm});

                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Add'),
                                    ),
                                  ],
                                );
                              });
                        },
                      );
                    },
                    icon: Icon(
                      Icons.nordic_walking,
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
                  height: bContainerHeight,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('day_data')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;

                            return Dismissible(
                              key: Key(snapshot.data!.docs[index].id),
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                    data['km'],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('day_data')
                                          .doc(snapshot.data!.docs[index].id)
                                          .delete();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ),
                              ),
                              onDismissed: (direction) {
                                FirebaseFirestore.instance
                                    .collection('km')
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
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
                  title: const Text('Activities Goal'),
                  textColor: Colors.white,
                  tileColor: Colors.red,
                  selectedTileColor: const Color.fromARGB(255, 255, 99, 64),
                  trailing: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Add an Activity'),
                                  content: TextField(
                                    onChanged: (String value) {
                                      _userActivities = value;
                                    },
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('day_data_activities')
                                            .add({
                                          'activities': _userActivities
                                        });

                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Add'),
                                    ),
                                  ],
                                );
                              });
                        },
                      );
                    },
                    icon: Icon(
                      Icons.sports_gymnastics,
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
                  height: lContainerHeight,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('day_data_activities')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;

                            return Dismissible(
                              key: Key(snapshot.data!.docs[index].id),
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                    data['activities'],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('day_data_activities')
                                          .doc(snapshot.data!.docs[index].id)
                                          .delete();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ),
                              ),
                              onDismissed: (direction) {
                                FirebaseFirestore.instance
                                    .collection('activities')
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
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
                  title: const Text('Hours of Sleep Goal'),
                  textColor: Colors.white,
                  tileColor: Colors.red,
                  selectedTileColor: const Color.fromARGB(255, 255, 99, 64),
                  trailing: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Add hours slept'),
                                  content: TextField(
                                    onChanged: (String value) {
                                      _userSleep = value;
                                    },
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('day_data_sleep')
                                            .add({'sleep': _userSleep});

                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Add'),
                                    ),
                                  ],
                                );
                              });
                        },
                      );
                    },
                    icon: Icon(
                      Icons.night_shelter,
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
                  height: dContainerHeight,
                  curve: Curves.fastOutSlowIn,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('day_data_sleep')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;

                            return Dismissible(
                              key: Key(snapshot.data!.docs[index].id),
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                    data['sleep'],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('day_data_sleep')
                                          .doc(snapshot.data!.docs[index].id)
                                          .delete();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ),
                              ),
                              onDismissed: (direction) {
                                FirebaseFirestore.instance
                                    .collection('sleep')
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
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
