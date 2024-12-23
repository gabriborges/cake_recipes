import 'package:flutter/material.dart';

class CakeSimpleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String readingTime;
  final String cookingTime;

  CakeSimpleCard({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.readingTime,
    required this.cookingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          Text(
            'Autor: $author',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Icon(Icons.timer, size: 14, color: Colors.grey[600]),
              SizedBox(width: 4.0),
              Text(
                readingTime,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Spacer(),
              Text(
                cookingTime,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
