//import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipefinal/spoon/recipe_model.dart';
//import 'package:recipefinal/spoon/recipe_model.dart';

class SpoonacularApi {
  final String apiKey;

  SpoonacularApi(this.apiKey);

  Future<Map<String, dynamic>> searchRecipes(String query) async {
    final response = await http.get(
      Uri.parse(
        'https://api.spoonacular.com/recipes/search',
      ).replace(queryParameters: {
        'query': query,
        'apiKey': apiKey,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<RecipeNew> getRecipeDetails(int recipeId) async {
    final response = await http.get(
      Uri.parse(
          'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=dee6cddc4b0d484db171c1e3264a4141'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> recipeData = json.decode(response.body);
      print("id is $recipeId");
      return RecipeNew(
        id: recipeData['id'],
        title: recipeData['title'],
        ingredients: List<String>.from(recipeData['extendedIngredients']
            .map((ingredient) => ingredient['original'])),

        instructions: recipeData['instructions'],
        // Add more mappings as needed
      );
    } else {
      throw Exception('Failed to load recipe details');
    }
  }

//trying
  // Future<Recipeingredient> getRecipeDetailsING(int recipeId) async {
  //   final response1 = await http.get(
  //     Uri.parse('https://api.spoonacular.com/recipes/findByIngredients'),
  //   );
  //   final response = await http.get(
  //     Uri.parse(
  //         'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=dee6cddc4b0d484db171c1e3264a4141'),
  //   );

  //   if (response1.statusCode == 200) {
  //     final Map<String, dynamic> recipeData = json.decode(response.body);
  //     final Map<String, dynamic> recipeData1 = json.decode(response1.body);
  //     return Recipeingredient(
  //       id: recipeData['id'],
  //       title: recipeData['title'],
  //       ingredients: List<String>.from(recipeData['missedIngredients']
  //           .map((ingredient) => ingredient['original'])),
  //       ingredientsIMG: List<String>.from(recipeData['missedIngredients']
  //           .map((ingredient) => ingredient['image'])),
  //       instructions: recipeData1['instructions'],
  //       // Add more mappings as needed
  //     );
  //   } else {
  //     throw Exception('Failed to load recipe details');
  //   }
  // }
}
