//import 'package:flutter/material.dart';
//import 'package:recipefinal/spoon/recipe_model.dart';
//import 'package:recipefinal/spoon/spoonacular_api.dart';

import 'package:flutter/material.dart';
import 'package:recipefinal/spoon/recipe_model.dart';
import 'package:recipefinal/spoon/spoonacular_api.dart';

class RecipeDetails extends StatelessWidget {
  final int recipeId;

  const RecipeDetails({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    String instruct(String reinstruct) {
      if (reinstruct.isNotEmpty) {
        if (reinstruct.contains("<li>")) {
          reinstruct = reinstruct.replaceAll("<li>", "");
        }
        if (reinstruct.contains("</li>")) {
          reinstruct = reinstruct.replaceAll("</li>", "");
        }
        if (reinstruct.contains("<p>")) {
          reinstruct = reinstruct.replaceAll("<p>", "");
        }
        if (reinstruct.contains("</p>")) {
          reinstruct = reinstruct.replaceAll("</p>", "");
        }
        if (reinstruct.contains("</ol>")) {
          reinstruct = reinstruct.replaceAll("</ol>", "");
        }
        if (reinstruct.contains("<ol>")) {
          reinstruct = reinstruct.replaceAll("<ol>", "");
        }
        if (reinstruct.contains(".")) {
          reinstruct = reinstruct.trim().replaceAll(".", "\n\n");
        }
        if (reinstruct.contains("<span>")) {
          reinstruct = reinstruct.trim().replaceAll("<span>", "");
        }
        if (reinstruct.contains("</span>")) {
          reinstruct = reinstruct.trim().replaceAll("</span>", "");
        }
      }

      return "* $reinstruct";
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.network(
              'https://spoonacular.com/recipeImages/$recipeId-636x393.jpg',
              fit: BoxFit.cover,
            ),
          ),
          DraggableScrollableSheet(
              maxChildSize: 1,
              initialChildSize: 0.6,
              minChildSize: 0.6,
              builder: (context, controller) {
                return SingleChildScrollView(
                  controller: controller,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<RecipeNew>(
                            future: SpoonacularApi(
                                    "dee6cddc4b0d484db171c1e3264a4141")
                                .getRecipeDetails(recipeId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                RecipeNew recipe = snapshot.data!;
                                return SingleChildScrollView(
                                    padding: const EdgeInsets.only(top: 25),
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              "#${recipe.title}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              "~Ingredients",
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: recipe.ingredients
                                                  .map((ingredient) => Text(
                                                        '- $ingredient',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                          //for instruction

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              "~Instruction",
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  instruct(recipe.instructions),
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                )
                                              ],
                                            ),
                                          ),
                                        ]));
                              }
                              return Text("NO DATA AVAILABLE");
                            })
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
/**  FutureBuilder<RecipeNew>(
        future: SpoonacularApi("dee6cddc4b0d484db171c1e3264a4141")
            .getRecipeDetails(recipeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            RecipeNew recipe = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.only(top: 25),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTitle36(recipe.title),
                        buildTitle16Variation("Do try this at home.....")
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 310,
                    padding: const EdgeInsets.only(left: 16),
                    child: Stack(
                      children: [
                        Container(
                          height: 310,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            'https://spoonacular.com/recipeImages/$recipeId-636x393.jpg',
                            fit: BoxFit.fitHeight,
                            height: 200,
                            // width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ingredients',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: recipe.ingredients
                              .map((ingredient) => Text('- $ingredient'))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Instructions',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          //recipe.instructions
                          instruct(recipe.instructions),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('No data available');
          }
        },
      ),
     */
