// ignore_for_file: prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:openfoodfacts/model/UserAgent.dart';
import 'package:openfoodfacts/model/parameter/SearchTerms.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/utils/AbstractQueryConfiguration.dart';
import 'package:openfoodfacts/utils/OpenFoodAPIConfiguration.dart';
import 'package:openfoodfacts/utils/QueryType.dart';

import '../model/food.dart';

class DishScreen extends StatefulWidget {
  const DishScreen({super.key, required UserAgent user});

  @override
  State<DishScreen> createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
  var iconPic = const Icon(Icons.star_border_outlined);
  List<bool> iconFav = [];
  final TextEditingController controller = TextEditingController();

  int sectionIndex = 1;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
        for (var i = 0; i < userList.ingredients.length; i++) {
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
                Expanded(
                  child: TextField(
                    controller: controller,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
<<<<<<< Updated upstream
                  onPressed: () {},
=======
                  onPressed: () {
                    ProductSearchQueryConfiguration configuration =
                        ProductSearchQueryConfiguration(
                      parametersList: <Parameter>[
                        //SearchTerms(terms: ['${controller.toString()}']),
                       // PageSize(size: 2),
                      ],
                    );
                    OpenFoodAPIClient.searchProducts(
                        User(userId: '', password: ''), configuration).then((value) {
                          Navigator.pushNamed(context, '/main', arguments: value);
                        });
                  },
>>>>>>> Stashed changes
                ),
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
                          icon: iconFav[index]
                              ? Icon(Icons.star)
                              : Icon(Icons.star_border_outlined),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          onPressed: () {
                            setState(() {
                              iconFav[index] = !iconFav[index];
                            });
                          },
                        ),
                        onTap: (() => Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/about',
                              (route) => false,
                            )),
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
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/day',
                      (route) => false,
                    );
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
                    Navigator.pushNamedAndRemoveUntil(
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
                    Navigator.pushNamedAndRemoveUntil(context, '/about',(route) => false,);
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
