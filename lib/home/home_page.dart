import 'package:cake_recipes/widget/cake_simple_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cake Recipes'),
        ),
        body: Column(
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
            Container(
              height: 300,
              width: double.infinity,
              child: CakeSimpleCard(
                  imageUrl:
                      'https://thescranline.com/wp-content/uploads/2023/06/BLACK-FOREST-CAKE-S-01.jpg',
                  title: 'Floresta Negra'),
            )
          ],
        ));
  }
}
