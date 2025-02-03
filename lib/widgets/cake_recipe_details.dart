import 'package:cake_recipes/pages/create_recipe/controller/star_rating_controller.dart';
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
  final double rating;
  final int views;

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
    required this.rating,
    required this.views,
  });

  final FavoriteController _favoriteController = Get.find<FavoriteController>();
  final StarRatingController _starRatingController =
      Get.put(StarRatingController());

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
              Stack(
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
                  // Positioned(
                  //   top: 8.0,
                  //   right: 8.0,
                  //   child: Container(
                  //     padding: EdgeInsets.all(8.0),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       shape: BoxShape.circle,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black26,
                  //           blurRadius: 4.0,
                  //           offset: Offset(0, 2),
                  //         ),
                  //       ],
                  //     ),
                  //     child: Icon(
                  //       size: 15,
                  //       Symbols.star,
                  //       color: Colors.yellow[700],
                  //       fill: 1,
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(
                              rating.toStringAsFixed(1).toString(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 1.0),
                            Icon(
                              size: 10,
                              Symbols.star,
                              color: Colors.yellow[700],
                              fill: 1,
                            ),
                          ],
                        )),
                  ),
                  Positioned(
                    bottom: 8.0,
                    right: 8.0,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Symbols.visibility,
                            size: 10,
                            color: Colors.black,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            views.toString(),
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              Text(
                'Avalie esta receita',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Symbols.star : Symbols.star_border,
                      color: Colors.yellow[700],
                      fill: index < rating ? 1 : 0,
                    ),
                    onPressed: () {
                      _starRatingController.addRating(recipeId, index + 1);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
