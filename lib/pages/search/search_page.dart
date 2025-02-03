import 'package:cake_recipes/pages/search/search_controller.dart/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cake_recipes/widgets/cake_card.dart';
import 'package:cake_recipes/widgets/floating_navigation_bar.dart';

class SearchPage extends StatelessWidget {
  final SearchPageController _searchController =
      Get.put(SearchPageController());
  final TextEditingController _searchControllerText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar Receitas'),
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
                    controller: _searchControllerText,
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
                    onSubmitted: (query) {
                      _searchController.searchRecipes(query);
                    },
                  ),
                ),
                Obx(() {
                  if (_searchController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (_searchController.searchResults.isEmpty) {
                    return Center(child: Text('Nenhuma receita encontrada'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _searchController.searchResults.length,
                    itemBuilder: (context, index) {
                      var recipe = _searchController.searchResults[index];
                      return CakeCard(
                        imageUrl: recipe['image_link'],
                        title: recipe['title'],
                        author: recipe['author_name'],
                        readingTime: recipe['reading_time_min'],
                        cookingTime: recipe['cooking_time_min'],
                        rating: recipe['rating'].toDouble(),
                        views: recipe['views'],
                        isFavorite: false,
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/recipePage',
                          arguments: {
                            'id': recipe['id'], // Pass the document ID
                            'image_link': recipe['image_link'],
                            'title': recipe['title'],
                            'author_name': recipe['author_name'],
                            'reading_time_min': recipe['reading_time_min'],
                            'cooking_time_min': recipe['cooking_time_min'],
                            'ingredients': recipe['ingredients'],
                            'preparation_method': recipe['preparation_method'],
                            'more_info': recipe['more_info'],
                            'rating': recipe['rating'],
                            'views': recipe['views'],
                          },
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
          FloatingNavigationBar(currentIndex: 1),
        ],
      ),
    );
  }
}
