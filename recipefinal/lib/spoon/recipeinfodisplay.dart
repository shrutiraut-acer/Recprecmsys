//import 'package:flutter/material.dart';
//import 'package:recipefinal/spoon/components.dart';
//import 'package:recipefinal/spoon/recipe_model.dart';
//import 'package:recipefinal/spoon/spoonacular_api.dart';

import 'package:flutter/material.dart';
import 'package:recipefinal/spoon/components.dart';
import 'package:recipefinal/spoon/recipe_model.dart';
import 'package:recipefinal/spoon/spoonacular_api.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final int recipeId;

  const RecipeDetailsScreen({super.key, required this.recipeId});

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
        if (reinstruct.contains("</ol>")) {
          reinstruct = reinstruct.replaceAll("</ol>", "");
        }
        if (reinstruct.contains("<ol>")) {
          reinstruct = reinstruct.replaceAll("<ol>", "");
        }
        if (reinstruct.contains(".")) {
          reinstruct = reinstruct.trim().replaceAll(".", "\n*");
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
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<RecipeNew>(
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
                  //important ahet............................................!!!!!!!!!!!!!
                  // Text(recipe.title,
                  //     style:
                  //         TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  // Text('Ingredients: ${recipe.ingredients.join(", \n")}'),

                  // const SizedBox(
                  //   height: 30,
                  // ),since it is a lsit therefore we use join() ok!!
                  // Text(
                  //     'Instructions: ${recipe.instructions.trim().split(".").join(", \n")}'),

                  // Image.network(
                  //   'https://spoonacular.com/recipeImages/$recipeId-636x393.jpg',
                  //   // Replace 'https://spoonacular.com/recipeImages/' with the actual base image URL
                  //   fit: BoxFit.cover,
                  //   height: 200,
                  //   width: MediaQuery.of(context).size.width,
                  // ),
                  // //image
                  // SizedBox(height: 16.0),
                  // Text(recipe.title,
                  //     style: TextStyle(
                  //         fontSize: 24, fontWeight: FontWeight.bold)),
                  // SizedBox(height: 16.0),
                  // Text('Ingredients:',
                  //     style: TextStyle(
                  //         fontSize: 18, fontWeight: FontWeight.bold)),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: recipe.ingredients
                  //       .map((ingredient) => Text('- $ingredient'))
                  //       .toList(),
                  // ),

                  // SizedBox(height: 16.0),
                  // Text('Instructions:',
                  //     style: TextStyle(
                  //         fontSize: 18, fontWeight: FontWeight.bold)),
                  // Text(recipe.instructions),
//???????????????????????????????????????????????????????????????????????????????????????????
                  // Image.network(
                  //   'https://spoonacular.com/recipeImages/$recipeId-636x393.jpg',
                  //   fit: BoxFit.cover,
                  //   height: 200,
                  //   width: MediaQuery.of(context).size.width,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Text(
                  //         'Ingredients',
                  //         style: TextStyle(
                  //             fontSize: 24, fontWeight: FontWeight.bold),
                  //       ),
                  //       const SizedBox(height: 4.0),
                  //       ListView.builder(
                  //         shrinkWrap: true,
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         itemCount: recipe.ingredients.length,
                  //         itemBuilder: (context, index) {
                  //           return ListTile(
                  //             contentPadding: const EdgeInsets.all(0),
                  //             title: Text('- ${recipe.ingredients[index]}'),
                  //           );
                  //         },
                  //       ),
                  //       const SizedBox(height: 16.0),
                  //       const Text(
                  //         'Instructions',
                  //         style: TextStyle(
                  //             fontSize: 24, fontWeight: FontWeight.bold),
                  //       ),
                  //       const SizedBox(height: 8.0),
                  // Text(
                  //   //recipe.instructions
                  //   instruct(recipe.instructions),
                  //   style: const TextStyle(fontSize: 16),
                  // ),
                  //     ],
                  //   ),
                  // ),
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
    );
  }
}
