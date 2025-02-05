import 'package:cake_recipes/pages/favorite/controller/favorite_controller.dart';
import 'package:cake_recipes/pages/home/controller/recipes_controller.dart';
import 'package:cake_recipes/pages/profile/controller/profile_controller.dart';
import 'package:cake_recipes/routes/routes.dart';
import 'package:cake_recipes/widgets/cake_card.dart';
import 'package:cake_recipes/widgets/floating_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  RecipesController recipesController = Get.put(RecipesController());

  Future<void> _refreshRecipes() async {
    await recipesController.fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas de Bolo'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/createRecipePage');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _refreshRecipes,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.offNamed(RoutesDesktop.searchPage);
                        print('Search');
                      },
                      child: IgnorePointer(
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
                          readOnly: true,
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (recipesController.isLoading.value) {
                      return Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recipesController.recipes.length,
                      itemBuilder: (context, index) {
                        var recipe = recipesController.recipes[index];
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
                            arguments: recipe,
                          ),
                        );
                      },
                    );
                  }),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
          FloatingNavigationBar(currentIndex: 0),
        ],
      ),
    );
  }
}
