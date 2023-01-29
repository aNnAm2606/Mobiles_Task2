import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Ingredient.dart';
import 'package:openfoodfacts/model/NutrientLevels.dart';
import 'package:openfoodfacts/model/Nutriments.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // a) Create a TextEditingController
  List<FoodClass> foodList = [];
  @override
  void didChangeDependencies() {
    // 2) Receive data from the calling screen
    foodList = ModalRoute.of(context)!.settings.arguments as List<FoodClass>;

    // c) Initialize controller from the arguments passed

    super.didChangeDependencies();
  }

  void initializeList() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Screen")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: foodList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: foodList[index].image != ''
                  ? Image.network(foodList[index].image)
                  : const CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.redAccent,
                    ),
              title: foodList[index].name != ''
                  ? Text(foodList[index].name)
                  : const Text('Name is missing'),
              subtitle: Text(foodList[index].quantity),
              onLongPress: () {
                 FirebaseFirestore.instance
                            .collection('items')
                            .add({'name': foodList[index].name, 'barcode' : foodList[index].barcode});
              },
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/food', arguments: foodList[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class FoodClass {
  String name = '';
  List<Ingredient> ingredients = [];
  String quantity = '';
  String image = '';
  String bigImage = '';
String barcode = '';
Nutriments nutriments;
String brand = '';
NutrientLevels nutriLevels;
  FoodClass(this.name, this.ingredients, this.brand, this.quantity, this.nutriments, this.nutriLevels, this.image, this.bigImage, this.barcode);
}
