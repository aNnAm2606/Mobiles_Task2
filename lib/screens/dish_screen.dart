// ignore_for_file: prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../model/food.dart';

class DishScreen extends StatefulWidget {
  const DishScreen({super.key});

  @override
  State<DishScreen> createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
  var iconPic = const Icon(Icons.star_border_outlined);
  List<bool> iconFav = [];
  
  int sectionIndex = 1;

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
        for (var i = 0; i < userList.ingredients.length; i++ )
        {
          iconFav.add(false);
        }
        return Scaffold(
            backgroundColor: Colors.grey[800],
            appBar: AppBar(
              title: Text(userList.name),
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
                          icon: iconFav[index]? Icon(Icons.star) : Icon(Icons.star_border_outlined),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          onPressed: () {
                            setState(() {
                              iconFav[index] = !iconFav[index];
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
            bottomNavigationBar: CurvedNavigationBar(
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
                  onPressed: () {
                    Navigator.pushNamed(context, '/day');
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  color: Colors.white,
                  onPressed: () {},
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
              index: 2,
              height: 50,
              color: Colors.white.withOpacity(0.5),
              buttonBackgroundColor: Colors.red,
              backgroundColor: Color.fromARGB(255, 52, 49, 49),
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 500),
              onTap: (int index) {
                setState(() => sectionIndex = index);
              },
            ));
      },
    );
  }
}
