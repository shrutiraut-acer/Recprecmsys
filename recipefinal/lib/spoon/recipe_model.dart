class Recipe {
  final int id;
  final String title;
  final String imageUrl;

  Recipe({required this.id, required this.title, required this.imageUrl});
}

class RecipeNew {
  final int id;
  final String title;
  final List<String> ingredients;
  final String instructions;

  RecipeNew({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.instructions,
  });
}

// class Recipeingredient {
//   final int id;
//   final String title;
//   final List<String> ingredients;
//   final String instructions;

//   final List<String> ingredientsIMG;

//   Recipeingredient({
//     required this.id,
//     required this.title,
//     required this.ingredients,
//     required this.ingredientsIMG,
//     required this.instructions,
//   });
// }
