// ignore_for_file: prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:deliverabl1task_2/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/NutrientLevels.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/model/parameter/SearchTerms.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../model/food.dart';

class DishScreen extends StatefulWidget {
  const DishScreen({super.key});

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
            body: Row(    
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    ProductSearchQueryConfiguration configuration =
                        ProductSearchQueryConfiguration(
                      parametersList: <Parameter>[
                        SearchTerms(terms: [(controller.value.text)]),
                      ],
                    );
                    OpenFoodAPIClient.searchProducts(
                            User(userId: '', password: ''), configuration)
                        .then((value) {
                      List<FoodClass> valueList = [];

                      for (var element in value.products!) {
                        valueList.add(
                          FoodClass(
                            element.productName != null
                                ? element.productName!
                                : '',
                            element.ingredients != null
                                ? element.ingredients!
                                : [],
                                element.brands != null
                                ? element.brands!
                                : '',
                            element.quantity != null ? element.quantity! : '',
                            element.nutriments != null ? element.nutriments! : [] as Nutriments,
                            element.nutrientLevels != null ? element.nutrientLevels! : [] as NutrientLevels,
                            element.imageFrontSmallUrl != null
                                ? element.imageFrontSmallUrl!
                                : '',
                                element.imageFrontUrl != null
                                ? element.imageFrontUrl!
                                : '',
                            element.barcode != null ? element.barcode! : '',
                          ),
                        );
                      }

                      Navigator.pushNamed(context, '/search',
                          arguments: valueList);
                    });
                  },
                ),
                

                //    trailing: IconButton(
                //      icon: iconFav[index]
                //          ? Icon(Icons.star)
                //          : Icon(Icons.star_border_outlined),
                //      color: const Color.fromARGB(255, 255, 255, 255),
                //      onPressed: () {
                //        setState(() {
                //          iconFav[index] = !iconFav[index];
                //        });
                //      },
                //    ),
                //    onTap: (() => Navigator.pushNamed(context, '/about')),
                //    title: Text(
                //      userList.ingredients[index],
                //    ),
                //  );
                //},
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
