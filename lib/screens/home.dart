import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List todoList = [];
  late String _userToDo;

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
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text('No Data');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index].get('item')),
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
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add an Element'),
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
                          .add({'item': _userToDo});

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
