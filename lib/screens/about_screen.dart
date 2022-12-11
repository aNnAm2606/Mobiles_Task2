import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About"), actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/');
          },
          child: const Icon(Icons.login),
        )
      ]),
      body: Column(
        children: [
          Expanded(child: _GroupInfo(), flex: 1,),
          Expanded(child: _Messages(), flex: 6),
        ],
      ),
    );
  }
}


class _Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return StreamBuilder(
      stream: db
          .collection("/group_name/mJ8ZN6d2MmZdTQCMwRbr/members")
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final querySnap = snapshot.data!;
        final docs = querySnap.docs;
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final message = docs[index];
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  color: Colors.white,
                  child: Text(message['member']),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _GroupInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return StreamBuilder(
      stream: db.doc("/group_info/mJ8ZN6d2MmZdTQCMwRbr").snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final docSnap = snapshot.data!;

        //final docs = docSnap.data.;
        //final docs = docSnap.docs;
        return Scaffold(
          body: Row(
            children: [
              Text(docSnap['group_name'], style: const TextStyle(fontSize: 24)),
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return const ListTile();
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
