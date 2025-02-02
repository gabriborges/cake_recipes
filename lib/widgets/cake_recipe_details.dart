import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:cake_recipes/pages/favorite/controller/favorite_controller.dart';

class CakeRecipeDetails extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final int readingTime;
  final int cookingTime;
  final bool isFavorite;
  final String ingredients;
  final String preparation;
  final String moreInfo;
  final String recipeId;

  CakeRecipeDetails({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.readingTime,
    required this.cookingTime,
    this.isFavorite = false,
    required this.ingredients,
    required this.preparation,
    required this.moreInfo,
    required this.recipeId,
  });

  final FavoriteController _favoriteController = Get.find<FavoriteController>();

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
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      'https://static.vecteezy.com/ti/vetor-gratis/p1/13149674-icone-de-imagem-indisponivel-em-moderno-estilo-plano-isolado-no-fundo-branco-simbolo-da-galeria-de-fotos-para-aplicativos-web-e-moveis-gratis-vetor.jpg',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
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
                  Obx(() {
                    bool isFavorite = _favoriteController.isFavorite(recipeId);
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Symbols.favorite : Symbols.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black,
                        fill: isFavorite ? 1 : 0,
                      ),
                      onPressed: () {
                        _favoriteController.toggleFavoriteStatus(recipeId);
                      },
                    );
                  }),
                ],
              ),
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
                      Icon(Symbols.schedule, size: 20, color: Colors.black),
                      SizedBox(width: 4.0),
                      Text(
                        '$readingTime min de leitura',
                        style: TextStyle(fontSize: 17, color: Colors.black),
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
              SizedBox(height: 16),
              moreInfo != ''
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mais Informações',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          moreInfo,
                          style: TextStyle(fontSize: 16),
                          softWrap: true,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
