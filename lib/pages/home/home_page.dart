import 'package:cake_recipes/pages/home/controller/recipes_controller.dart';
import 'package:cake_recipes/widgets/cake_card.dart';
import 'package:cake_recipes/widgets/floating_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final RecipesController _recipesController = Get.put(RecipesController());

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
                  if (_recipesController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _recipesController.recipes.length,
                    itemBuilder: (context, index) {
                      var recipe = _recipesController.recipes[index];
                      return CakeCard(
                        imageUrl: recipe['image_link'],
                        title: recipe['title'],
                        author: recipe['author_name'],
                        readingTime: recipe['reading_time_min'],
                        cookingTime: recipe['cooking_time_min'],
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
          FloatingNavigationBar(currentIndex: 0),
        ],
      ),
    );
  }
}
