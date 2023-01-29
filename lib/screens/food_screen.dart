// ignore_for_file: deprecated_member_use

import 'package:deliverabl1task_2/screens/search_screen.dart';
import 'package:flutter/material.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  // a) Create a TextEditingController
  // ignore: avoid_init_to_null
  FoodClass? food = null;

  @override
  void didChangeDependencies() {
    // 2) Receive data from the calling screen
    food = ModalRoute.of(context)!.settings.arguments as FoodClass;

    // c) Initialize controller from the arguments passed

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(food!.name)),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Center(
                child: Image.network(food!.bigImage),
              ),
            ),
          ),
          Expanded(
              flex: 6,
              child: Container(
                color: Colors.grey[800],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      separator(10, 500),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            food!.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                color: Colors.white),
                          ),
                          separator(1, 10),
                          Text(
                            food!.quantity,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      separator(10, 500),
                      nutrientStyle( 'fat', food!.nutriments.fat.toString()),
                      nutrientStyle( 'Carbs', food!.nutriments.carbohydrates.toString()),
                      nutrientStyle( 'Protein', food!.nutriments.proteins.toString()),
                      separator(10, 1),
                      Expanded(
                        child: ListView.builder(
                          itemCount: food!.ingredients.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(food!.ingredients[index].text!),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

Widget nutrientStyle(String name, String number) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        name,
        style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
      ),
      separator(1, 10),
      Text(
        '$number g ',
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      const Text(
        '(for every 100 g)',
        style: TextStyle(fontSize: 16, color: Colors.white60),
      ),
    ],
  );
}

Widget separator(double h, double w) {
  return SizedBox(
    height: h,
    width: w,
  );
}
