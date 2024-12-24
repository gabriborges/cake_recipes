import 'package:cake_recipes/widgets/cake_card.dart';
import 'package:cake_recipes/widgets/floating_navigation_bar.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
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
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CakeCard(
                      imageUrl:
                          'https://thescranline.com/wp-content/uploads/2023/06/BLACK-FOREST-CAKE-S-01.jpg',
                      title: 'Floresta Negra',
                      author: 'Ryan Gosling',
                      readingTime: 5,
                      cookingTime: 45,
                      isFavorite: true,
                    ),
                    Container(
                      height: 90,
                    ),
                  ],
                ),
              ],
            ),
          ),
          FloatingNavigationBar(currentIndex: 2),
        ],
      ),
    );
  }
}
