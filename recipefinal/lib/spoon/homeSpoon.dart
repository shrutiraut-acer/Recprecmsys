//import 'package:flutter/material.dart';
//import 'package:recipefinal/spoon/recipe_model.dart';
//import 'package:recipefinal/spoon/recipeinfodisplay.dart';
//import 'package:recipefinal/spoon/spoonacular_api.dart';

import 'package:flutter/material.dart';
import 'package:recipefinal/spoon/recipe_model.dart';
import 'package:recipefinal/spoon/recipeinfodisplay.dart';
import 'package:recipefinal/spoon/spoonacular_api.dart';

class SpoonMyHomePage extends StatefulWidget {
  @override
  _SpoonMyHomePageState createState() => _SpoonMyHomePageState();
}

class _SpoonMyHomePageState extends State<SpoonMyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final SpoonacularApi _spoonacularApi =
      SpoonacularApi('dee6cddc4b0d484db171c1e3264a4141');
  List<Recipe> _recipes = [];

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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spoonacular Recipe App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Recipes',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _searchRecipes,
              child: Text('Search'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child:
                  // ListView.builder(
                  //   itemCount: _recipes.length,
                  //   itemBuilder: (context, index) {
                  //     final recipe = _recipes[index];
                  //     return
                  //         // ListTile(
                  //         //   title: Text(recipe.title),
                  //         //   leading: Image.network(recipe.imageUrl),
                  //         // )
                  //         Container(
                  //       height: 150,
                  //       width: MediaQuery.of(context).size.width,
                  //       child: Column(children: [
                  //         Text(recipe.title),
                  //         Container(
                  //           height: 100,
                  //           width: MediaQuery.of(context).size.width - 20,
                  //           child: recipe.imageUrl.startsWith('http')
                  //               ? Image.network(recipe.imageUrl)
                  //               : Image.file(File(recipe.imageUrl)),
                  //         ),
                  //       ]),
                  //     );
                  //   },
                  // ),
                  ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  final recipe = _recipes[index];
                  return
                      //changing ........................................................
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RecipeDetailsScreen(recipeId: recipe.id),
                              ),
                            );
                          },
                          child:
                              // ListTile(
                              //   title: Text(recipe.title),
                              //   leading: Image.network(
                              //       "https://spoonacular.com/recipeImages/${recipe.imageUrl}"),
                              // ),
                              ListTile(
                            title: AspectRatio(
                                aspectRatio: 0.9 / 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: ClipRRect(
                                          child: Image.network(
                                              "https://spoonacular.com/recipeImages/${recipe.imageUrl}"),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),

                                    ///Add Text Also,
                                    SizedBox(
                                      height: 8,
                                    ),

                                    ///For spacing

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        "${recipe.title} ",
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 11),
                                      ),
                                    )
                                  ],
                                )),
                          ))

//changing end......................................................

                      // GestureDetector(
                      //   onTap: () {},
                      //   child: ListTile(
                      //     title: Text(recipe.title),
                      //     leading: Image.network(
                      //         "https://spoonacular.com/recipeImages/${recipe.imageUrl}"),
                      //   ),
                      // )

                      ;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
