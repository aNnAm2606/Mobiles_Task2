import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Ingredient.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // a) Create a TextEditingController
  List<foodClass> foodList = [];
  @override
  void didChangeDependencies() {
    // 2) Receive data from the calling screen
    foodList = ModalRoute.of(context)!.settings.arguments as List<foodClass>;

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
                    ? Image.network('${foodList[index].image}')
                    : const CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Colors.redAccent,
                      ),
                title: Text('${foodList[index].name}'),
                subtitle: Text('${foodList[index].quantity}'),
              );
            },
          )),
    );
  }
}

class foodClass {
  String name = '';
  List<Ingredient> ingredients = [];
  String quantity = '';
  String image = '';

  foodClass(String? name, List<Ingredient> ingredientList, String quantity,
      String imageUrl) {
    if (name != Null) this.name = name!;
    ingredients = ingredientList;
    this.quantity = quantity;
    image = imageUrl;
  }
}
