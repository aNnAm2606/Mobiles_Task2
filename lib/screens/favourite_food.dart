import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:deliverabl1task_2/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:openfoodfacts/model/NutrientLevels.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/model/parameter/BarcodeParameter.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class FavouriteFood extends StatefulWidget {
  const FavouriteFood({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavouriteFoodState createState() => _FavouriteFoodState();
}

class _FavouriteFoodState extends State<FavouriteFood> {
  List todoList = [];
  late String _userToDo;
  int sectionIndex = 2;
  String name = "";

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();

    todoList.addAll(
      ['Buy', 'Add', 'Clean'],
    );
  }

  @override
  Widget build(BuildContext context) {
    var curvedNavigationBar = CurvedNavigationBar(
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
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/tryings',
              (route) => false,
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.star,
          ),
          color: Colors.white,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.info,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/about',
              (route) => false,
            );
          },
        ),
      ],
      index: 3,
      height: 50,
      color: Colors.white.withOpacity(0.5),
      buttonBackgroundColor: Colors.red,
      backgroundColor: const Color.fromARGB(255, 52, 49, 49),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
      onTap: (int index) {
        setState(() => sectionIndex = index);
      },
    );
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
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
          title: Card(
            child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search Favourite Food...'),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('items').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  if (name.isEmpty) {
                    return Dismissible(
                      key: Key(snapshot.data!.docs[index].id),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            data['name'],
                          ),
                          onTap: () {
                            if (data['barcode'] != null) {
                              ProductSearchQueryConfiguration configuration =
                                  ProductSearchQueryConfiguration(
                                parametersList: <Parameter>[
                                  BarcodeParameter(data['barcode']),
                                ],
                              );
                              OpenFoodAPIClient.searchProducts(
                                      const User(userId: '', password: ''),
                                      configuration)
                                  .then(
                                (value) {
                                  FoodClass aux = FoodClass(
                                    value.products![0].productName != null
                                        ? value.products![0].productName!
                                        : '',
                                    value.products![0].ingredients != null
                                        ? value.products![0].ingredients!
                                        : [],
                                        value.products![0].brands != null
                                ? value.products![0].brands!
                                : '',
                                    value.products![0].quantity != null
                                        ? value.products![0].quantity!
                                        : '',
                                         value.products![0].nutriments != null ?  value.products![0].nutriments! : [] as Nutriments,
                             value.products![0].nutrientLevels != null ?  value.products![0].nutrientLevels! : [] as NutrientLevels,
                                    value.products![0].imageFrontSmallUrl !=
                                            null
                                        ? value.products![0].imageFrontSmallUrl!
                                        : '',
                                         value.products![0].imageFrontUrl != null
                                ?  value.products![0].imageFrontUrl!
                                : '',
                                    value.products![0].barcode != null
                                        ? value.products![0].barcode!
                                        : '',
                                  );
                                  Navigator.pushNamed(context, '/food',
                                      arguments: aux);
                                },
                              );
                            }
                          },
                          trailing: IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('items')
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();
                            },
                            icon: const Icon(
                              Icons.star,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        FirebaseFirestore.instance
                            .collection('items')
                            .doc(snapshot.data!.docs[index].id)
                            .delete();
                      },
                    );
                  }
                  if (data['name']
                      .toString()
                      .toLowerCase()
                      .startsWith(name.toLowerCase())) {
                    return Dismissible(
                      key: Key(snapshot.data!.docs[index].id),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            data['name'],
                          ),
                          onLongPress: () {
                            if (data['barcode'] != null) {
                              ProductSearchQueryConfiguration configuration =
                                  ProductSearchQueryConfiguration(
                                parametersList: <Parameter>[
                                  BarcodeParameter(data['barcode']),
                                ],
                              );
                              OpenFoodAPIClient.searchProducts(
                                      const User(userId: '', password: ''),
                                      configuration)
                                  .then((value) {
                                  FoodClass aux = FoodClass(
                                    value.products![0].productName != null
                                        ? value.products![0].productName!
                                        : '',
                                    value.products![0].ingredients != null
                                        ? value.products![0].ingredients!
                                        : [],
                                        value.products![0].brands != null
                                ? value.products![0].brands!
                                : '',
                                    value.products![0].quantity != null
                                        ? value.products![0].quantity!
                                        : '',
                                         value.products![0].nutriments != null ?  value.products![0].nutriments! : [] as Nutriments,
                             value.products![0].nutrientLevels != null ?  value.products![0].nutrientLevels! : [] as NutrientLevels,
                                    value.products![0].imageFrontSmallUrl !=
                                            null
                                        ? value.products![0].imageFrontSmallUrl!
                                        : '',
                                         value.products![0].imageFrontUrl != null
                                ?  value.products![0].imageFrontUrl!
                                : '',
                                    value.products![0].barcode != null
                                        ? value.products![0].barcode!
                                        : '',
                                  );
                                  Navigator.pushNamed(context, '/food',
                                      arguments: aux);
                                },);
                            }
                          },
                          trailing: IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('items')
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();
                            },
                            icon: const Icon(
                              Icons.delete_sweep,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        FirebaseFirestore.instance
                            .collection('items')
                            .doc(snapshot.data!.docs[index].id)
                            .delete();
                      },
                    );
                  }
                  return Container();
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add a Favourite Food'),
                  content: TextField(
                    onChanged: (String value) {
                      _userToDo = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('items')
                            .add({'name': _userToDo});

                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add_box, color: Colors.white),
        ),
        bottomNavigationBar: curvedNavigationBar);
  }
}
