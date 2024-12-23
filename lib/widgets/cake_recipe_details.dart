import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CakeRecipeDetails extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final int readingTime;
  final int cookingTime;
  final bool isFavorite;
  final String ingredients;
  final String preparation;

  CakeRecipeDetails({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.readingTime,
    required this.cookingTime,
    this.isFavorite = false,
    required this.ingredients,
    required this.preparation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  isFavorite
                      ? Icon(
                          Symbols.favorite,
                          color: Colors.red,
                          fill: 1.0,
                        )
                      : Icon(
                          Symbols.favorite,
                          color: Colors.black,
                        ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'por $author',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Symbols.schedule, size: 14, color: Colors.grey[600]),
                      SizedBox(width: 4.0),
                      Text(
                        '$readingTime min de leitura',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Symbols.skillet, size: 20),
                      SizedBox(width: 4.0),
                      Text(
                        '$cookingTime min',
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Ingredientes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                ingredients,
                style: TextStyle(fontSize: 16),
                softWrap: true,
              ),
              SizedBox(height: 16),
              Text(
                'Modo de Preparo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                preparation,
                style: TextStyle(fontSize: 16),
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
