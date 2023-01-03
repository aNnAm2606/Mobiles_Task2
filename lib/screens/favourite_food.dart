import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FavouriteFood extends StatefulWidget {
  const FavouriteFood({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavouriteFoodState createState() => _FavouriteFoodState();
}

class _FavouriteFoodState extends State<FavouriteFood> {
  List todoList = [];
  late String _userToDo;

  String name = "";

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();

    todoList.addAll(
      ['Buy', 'Add', 'Clean'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Favourite Food...'),
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                if (name.isEmpty) {
                  return Dismissible(
                    key: Key(snapshot.data!.docs[index].id),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          data['name'],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('items')
                                .doc(snapshot.data!.docs[index].id)
                                .delete();
                          },
                          icon: const Icon(
                            Icons.star,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      FirebaseFirestore.instance
                          .collection('items')
                          .doc(snapshot.data!.docs[index].id)
                          .delete();
                    },
                  );
                }
                if (data['name']
                    .toString()
                    .toLowerCase()
                    .startsWith(name.toLowerCase())) {
                  return Dismissible(
                    key: Key(snapshot.data!.docs[index].id),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          data['name'],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('items')
                                .doc(snapshot.data!.docs[index].id)
                                .delete();
                          },
                          icon: const Icon(
                            Icons.delete_sweep,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      FirebaseFirestore.instance
                          .collection('items')
                          .doc(snapshot.data!.docs[index].id)
                          .delete();
                    },
                  );
                }
                return Container();
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 102, 64),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add a Favourite Food'),
                content: TextField(
                  onChanged: (String value) {
                    _userToDo = value;
                  },
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('items')
                          .add({'name': _userToDo});

                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add_box, color: Colors.white),
      ),
    );
  }
}
