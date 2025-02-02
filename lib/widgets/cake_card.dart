import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CakeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final int readingTime;
  final int cookingTime;
  final bool isFavorite;
  final VoidCallback? onTap;

  CakeCard({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.readingTime,
    required this.cookingTime,
    this.isFavorite = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        'https://static.vecteezy.com/ti/vetor-gratis/p1/13149674-icone-de-imagem-indisponivel-em-moderno-estilo-plano-isolado-no-fundo-branco-simbolo-da-galeria-de-fotos-para-aplicativos-web-e-moveis-gratis-vetor.jpg',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      size: 15,
                      Symbols.share,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'por $author',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Symbols.schedule, size: 14, color: Colors.black),
                          SizedBox(width: 4.0),
                          Text(
                            '$readingTime min de leitura',
                            style: TextStyle(fontSize: 14, color: Colors.black),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
