import 'dart:html';

import 'package:flutter/material.dart';

import '../model/food.dart';

class DishScreen extends StatefulWidget {
  DishScreen({super.key});

  @override
  State<DishScreen> createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
  var iconPic = const Icon(Icons.star_border_outlined);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadUserList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final userList = snapshot.data!;
        return Scaffold(
          backgroundColor: Colors.grey[800],
          appBar: AppBar(title: Text(userList.name)),
          body: Column(
            children: [
              const Expanded(
                  flex: 1,
                  child: Text('Foods', style: TextStyle(fontSize: 20))),
              Expanded(
                flex: 11,
                child: ListView.builder(
                  itemCount: userList.ingredients.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: IconButton(
                        icon: iconPic,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        onPressed: () {
                          setState(() {
                            iconPic = const Icon(Icons.star);
                          });
                        },
                      ),
                      onTap: (() => Navigator.pushNamed(context, '/about')),
                      title: Text(
                        userList.ingredients[index],
                      ),
                    );
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
