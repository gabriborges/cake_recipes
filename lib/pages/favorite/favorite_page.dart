import 'package:cake_recipes/widgets/cake_card.dart';
import 'package:cake_recipes/widgets/floating_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cake_recipes/pages/favorite/controller/favorite_controller.dart';

class FavoritePage extends StatelessWidget {
  final FavoriteController _favoriteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas favoritas'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Pesquisar',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                Obx(() {
                  if (_favoriteController.favoriteRecipes.isEmpty) {
                    return Center(child: Text('Nenhuma receita favorita'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _favoriteController.favoriteRecipes.length,
                    itemBuilder: (context, index) {
                      String recipeId =
                          _favoriteController.favoriteRecipes[index];
                      return FutureBuilder<Map<String, dynamic>?>(
                        future:
                            _favoriteController.fetchRecipeDetails(recipeId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError || !snapshot.hasData) {
                            return Center(
                                child: Text('Erro ao carregar receita'));
                          }
                          var recipe = snapshot.data!;
                          return CakeCard(
                            imageUrl: recipe['image_link'],
                            title: recipe['title'],
                            author: recipe['author_name'],
                            readingTime: recipe['reading_time_min'],
                            cookingTime: recipe['cooking_time_min'],
                            isFavorite: true,
                            rating: recipe['rating'].toDouble(),
                            views: recipe['views'],
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/recipePage',
                              arguments: recipe,
                            ),
                          );
                        },
                      );
                    },
                  );
                }),
              ],
            ),
          ),
          FloatingNavigationBar(currentIndex: 2),
        ],
      ),
    );
  }
}
