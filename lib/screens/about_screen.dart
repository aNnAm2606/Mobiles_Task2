import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
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
          Expanded(
            flex: 1,
            child: _GroupInfo(),
          ),
        ],
      ),
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(docSnap['group_name'],
                    style: const TextStyle(fontSize: 24)),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  docSnap['member_01'],
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  docSnap['member_02'],
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
