import 'package:flutter/material.dart';
import 'package:cake_recipes/widgets/cake_recipe_details.dart';

class RecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> recipe =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return CakeRecipeDetails(
      imageUrl: recipe['image_link'],
      title: recipe['title'],
      author: recipe['author_name'],
      readingTime: recipe['reading_time_min'],
      cookingTime: recipe['cooking_time_min'],
      isFavorite: false,
      ingredients: recipe['ingredients'],
      preparation: recipe['preparation_method'],
    );
  }
}
