import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Dish {
  late String name;
  late List<String> ingredients;

  Dish({
    required this.name,
    required this.ingredients,
  });

  void addIngredients(List<String> list) {
    ingredients = list;
  }

  Dish.fromJson(Map<String, dynamic> json)
      : name = "${json["product"]["generic_name_en"]}";
  //ingredients = "${json["product"]["generic_name_en"]}";
  // email = json["email"],
  // age = json["dob"]["age"],
  // nationality = json["nat"],
  // avatarUrl = json["picture"]["large"];

  
}

Future<Dish> loadUserList() async {
  final uri = Uri.parse(
      "https://world.openfoodfacts.org/api/v0/product/737628064502.json");
  final response = await http.get(uri);
  final json = jsonDecode(response.body);
  
  Dish dishTry = Dish.fromJson(json);
  dishTry.addIngredients(loadIngredients(json));
  return dishTry;
}

Future<String> loadFile(String filename) async {
  final file = File(filename);
  final content = await file.readAsString();
  return content;
}

List<String> loadIngredients(dynamic json) {
  List<String> ingredientsList = [];
  for (final jsonUser in json["product"]["ingredients"]) {
    ingredientsList.add("${jsonUser["text"]}");
  }

  return ingredientsList;
}
