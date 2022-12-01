import 'package:flutter/material.dart';

import '../model/food.dart';

class DishScreen extends StatelessWidget {
  const DishScreen({super.key});

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
          appBar: AppBar(title: Text(userList.name)),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: userList.ingredients.length,
                  itemBuilder: (context, index) {
                    return ListTile(
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
