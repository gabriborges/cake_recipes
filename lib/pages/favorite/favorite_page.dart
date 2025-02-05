import 'package:cake_recipes/widgets/cake_card.dart';
import 'package:cake_recipes/widgets/floating_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cake_recipes/pages/favorite/controller/favorite_controller.dart';

class FavoritePage extends StatelessWidget {
  final FavoriteController _favoriteController = Get.find();

  Future<void> _refreshFavorites() async {
    await _favoriteController.fetchFavoriteRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas favoritas'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          RefreshIndicator(
            onRefresh: _refreshFavorites,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Obx(() {
                    if (_favoriteController.favoriteRecipes.isEmpty) {
                      return Center(
                          child: Text(
                              textAlign: TextAlign.center,
                              'Nenhuma receita favorita encontrada,\ntente favoritar uma receita ou\natualizar a pagina.'));
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
          ),
          FloatingNavigationBar(currentIndex: 2),
        ],
      ),
    );
  }
}
