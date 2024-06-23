//import 'dart:convert';
//import 'dart:ui';
import 'package:http/http.dart' as http;
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:recipefinal/login.dart';
//import 'package:recipefinal/spoon/recipe_model.dart';
import 'dart:math' as math;
//import 'package:recipefinal/spoon/screen/aftersearch.dart';
//import 'package:recipefinal/spoon/screen/recipedetails.dart';
//import 'package:recipefinal/spoon/spoonacular_api.dart';

import 'dart:convert';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipefinal/login.dart';
import 'package:recipefinal/spoon/recipe_model.dart';
import 'package:recipefinal/spoon/screen/aftersearch.dart';
import 'package:recipefinal/spoon/screen/recipedetails.dart';
import 'package:recipefinal/spoon/spoonacular_api.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int selectedIndex = 0;
  bool sea = false, seeRecipeRecent = false;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  final SpoonacularApi _spoonacularApi =
      SpoonacularApi('dee6cddc4b0d484db171c1e3264a4141');
  List<Recipe> _recipes = [];
  List<String> ingredients = [];
  List searchResults = [];
  Future<void> _searchRecipesByIngredients() async {
    final String apiKey =
        'dee6cddc4b0d484db171c1e3264a4141'; // Replace with your Spoonacular API key
    final String ingredientsQuery = ingredients.join(',');
    final String url =
        'https://api.spoonacular.com/recipes/findByIngredients?ingredients=$ingredientsQuery&number=10&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        searchResults = (responseData as List)
            .map((json) => Recipe(
                  id: json['id'],
                  title: json['title'],
                  imageUrl: json['image'],
                ))
            .toList();
        sea = true;
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AfterSearch(listrecipe: searchResults);
        }));
      });
    } else {
      throw Exception('Failed to search recipes by ingredients');
    }
  }

  /*
  Future<void> _searchRecipesByIngredients() async {
    final String apiKey =
        'dee6cddc4b0d484db171c1e3264a4141'; // Replace with your Spoonacular API key
    final String ingredientsQuery = ingredients.join(',');
    final String url =
        'https://api.spoonacular.com/recipes/findByIngredients?ingredients=$ingredientsQuery&number=10&apiKey=$apiKey';

    if (ingredients.isEmpty) {
      // Show dialog if ingredients list is empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Empty Ingredients List"),
            content: Text("Please enter ingredients before searching."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        searchResults = (responseData as List)
            .map((json) => Recipe(
                  id: json['id'],
                  title: json['title'],
                  imageUrl: json['image'],
                ))
            .toList();
        sea = true;
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AfterSearch(listrecipe: searchResults);
        }));
      });
    } else {
      throw Exception('Failed to search recipes by ingredients');
    }
  }
*/
  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  // void _searchRecipes() async {
  //   final query = _searchController.text;

  //   if (query.isNotEmpty) {
  //     final result = await _spoonacularApi.searchRecipes(query);
  //     setState(() {
  //       _recipes = (result['results'] as List)
  //           .map((json) => Recipe(
  //                 id: json['id'],
  //                 title: json['title'],
  //                 imageUrl: json['image'],
  //               ))
  //           .toList();
  //       seeRecipeRecent = true;
  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //         return AfterSearch(listrecipe: _recipes);
  //       }));
  //     });
  //   }
  // }

  void _searchRecipes() async {
    final query = _searchController.text;

    if (query.isNotEmpty) {
      final result = await _spoonacularApi.searchRecipes(query);
      setState(() {
        _recipes = (result['results'] as List)
            .map((json) => Recipe(
                  id: json['id'],
                  title: json['title'],
                  imageUrl: json['image'],
                ))
            .toList();
        seeRecipeRecent = true;
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AfterSearch(listrecipe: _recipes);
        }));
      });
    } else {
      // Show dialog if search query is empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Empty Search Query"),
            content: Text("Please enter a search query before searching."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  ///Image paths and food names
  final images = [
    "assets/images/burger.jpg",
    "assets/images/chicken_g.jpg",
    "assets/images/spaghetti.jpg",
    "assets/images/chiken_f.jpeg",
    "assets/images/pizza.jpg",
  ];

  final foodNames = [
    "Grilled Burger",
    "Grilled Chicken",
    "spaghetti",
    "Crispy Fried Chicken",
    "Pizza",
  ];

  @override
  Widget build(BuildContext context) {
    ///For screen size

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                });
              },
              icon: const Icon(
                Icons.logout,
                size: 25,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: const Center(
          child: Text(
            "RECIPE",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        //container hota remove kelay width double.infinity hoti ani padding child madhe singlechildscroollview hota
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Find best recipe for cooking! ",
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: MediaQuery.of(context).size.width - 102,
                          child: TextField(
                            controller: _ingredientController,
                            decoration: InputDecoration(
                              labelText: 'Enter Ingredients',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    ingredients
                                        .add(_ingredientController.text.trim());
                                    _ingredientController.clear();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(0)),
                          //onPressed: _searchRecipes,
//trying
                          onPressed: () {
                            if (ingredients.isNotEmpty) {
                              _searchRecipesByIngredients();
                              ingredients.clear();
                            } else {
                              //msg neter the data
                              print("enter!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Empty Ingredients List"),
                                    content: Text(
                                        "Please enter ingredients before searching."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },

                          child: const Icon(
                            Icons.search,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Wrap(
                  children: [
                    for (int i = 0; i < ingredients.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Chip(
                          backgroundColor: Color(
                                  (math.Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                              .withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.5)),
                          label: Text(ingredients[i]),
                          onDeleted: () {
                            setState(() {
                              ingredients.remove(ingredients[i]);
                            });
                          },
                          deleteIcon: Icon(
                            Icons.close,
                            size: 18,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),

              ///Container For List of Recipes type
              ///Give 25 percent height relative to screen---------------title black color cha ribbon use karun try
              Container(
                height: size.height * 0.25,
                child: sea
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // final recipe = _recipes[index];
                          //trying
                          final recipe = searchResults[index];
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            // RecipeDetailsScreen(
                                            //     recipeId: recipe.id),
                                            //trying
                                            //AfterSearch(listrecipe: _recipes)
                                            // AfterSearch(
                                            //     listrecipe: searchResults)
                                            RecipeDetails(recipeId: recipe.id)),
                                  );
                                },
                                child: AspectRatio(
                                    aspectRatio: 0.9 / 1,

                                    ///Width : screen,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            height: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child:
                                                  //trying
                                                  Image.network(
                                                'https://spoonacular.com/recipeImages/${recipe.id}-636x393.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),

                                        ///Add Text Also,
                                        const SizedBox(
                                          height: 8,
                                        ),

                                        ///For spacing

                                        // Padding(
                                        //   padding: const EdgeInsets.symmetric(
                                        //       horizontal: 16.0),
                                        //   child: Text(
                                        //     "${recipe.title} ",
                                        //     style: const TextStyle(
                                        //       color: Colors.black,
                                        //       //Colors.orange,
                                        //       fontSize: 13,
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    )),
                              ),
                              Positioned(
                                  bottom: 8,
                                  left: 1,
                                  right: 1,
                                  child: ClipRRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        child: Text(
                                          "${recipe.title}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          );
                        },
                        separatorBuilder: (context, _) => const SizedBox(
                              width: 16,
                            ),
                        itemCount: searchResults.length)
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              AspectRatio(
                                  aspectRatio: 0.9 / 1,

                                  ///Width : screen,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.asset(
                                              images[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),

                                      ///Add Text Also,
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  )),
                              Positioned(
                                  bottom: 8,
                                  left: 1,
                                  right: 1,
                                  child: ClipRRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        child: Text(
                                          "${foodNames[index]} Recipes",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          );
                        },
                        separatorBuilder: (context, _) => const SizedBox(
                              width: 16,
                            ),
                        itemCount: 4),
              ),

              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: MediaQuery.of(context).size.width - 102,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search Recipe',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0)),
                    onPressed: () {
                      _searchRecipes();
                      _searchController.clear();
                    },
                    child: const Icon(
                      Icons.search,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),

              ///For quick recipe list
              Container(
                height: size.height * 0.33,
                child: seeRecipeRecent
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final recipe = _recipes[index];

                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RecipeDetails(recipeId: recipe.id)),
                                  );
                                },
                                child: AspectRatio(
                                    aspectRatio: 0.9 / 1,

                                    ///Width : screen,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            height: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child:
                                                  //trying
                                                  Image.network(
                                                'https://spoonacular.com/recipeImages/${recipe.id}-636x393.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),

                                        ///Add Text Also,
                                        const SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    )),
                              ),
                              Positioned(
                                  bottom: 8,
                                  left: 1,
                                  right: 1,
                                  child: ClipRRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        child: Text(
                                          recipe.title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          );
                        },
                        separatorBuilder: (context, _) => const SizedBox(
                              width: 16,
                            ),
                        itemCount: _recipes.length)
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() async {
                                    final query = "${foodNames[4 - index]}";

                                    if (query.isNotEmpty) {
                                      final result = await _spoonacularApi
                                          .searchRecipes(query);
                                      setState(() {
                                        _recipes = (result['results'] as List)
                                            .map((json) => Recipe(
                                                  id: json['id'],
                                                  title: json['title'],
                                                  imageUrl: json['image'],
                                                ))
                                            .toList();

                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return AfterSearch(
                                              listrecipe: _recipes);
                                        }));
                                      });
                                    }
                                  });
                                },
                                child: AspectRatio(
                                    aspectRatio: 0.9 / 1,

                                    ///Width : screen,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                images[foodNames.length -
                                                    1 -
                                                    index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Positioned(
                                  bottom: 0.5,
                                  left: 1,
                                  right: 1,
                                  child: ClipRRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        child: Text(
                                          "${foodNames[foodNames.length - 1 - index]}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          );
                        },
                        separatorBuilder: (context, _) => const SizedBox(
                              width: 16,
                            ),
                        itemCount: 4),
              )
            ],
          ),
        ),
      ),
    );
  }
}
