import 'package:cake_recipes/widgets/cake_card.dart';
import 'package:cake_recipes/widgets/floating_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cake_recipes/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
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
                          'https://receitatodahora.com.br/wp-content/uploads/2024/09/bolo-de-cenoura-31087-1024x683.jpg',
                      title: 'Cenoura',
                      author: 'Ryan Gosling',
                      readingTime: 3,
                      cookingTime: 40,
                      isFavorite: false,
                      onTap: () => Navigator.pushNamed(context, '/recipePage'),
                    ),
                    CakeCard(
                      imageUrl:
                          'https://thescranline.com/wp-content/uploads/2023/06/BLACK-FOREST-CAKE-S-01.jpg',
                      title: 'Floresta Negra',
                      author: 'Ryan Gosling',
                      readingTime: 5,
                      cookingTime: 45,
                    ),
                    CakeCard(
                      imageUrl:
                          'https://i0.statig.com.br/bancodeimagens/6m/qo/0o/6mqo0o4u3a9f9sd9jlz8qhjde.jpg',
                      title: 'Macaxeira',
                      author: 'Ryan Gosling',
                      readingTime: 3,
                      cookingTime: 40,
                      isFavorite: true,
                    ),
                    CakeCard(
                      imageUrl:
                          'https://bakeandcakegourmet.com.br/uploads/site/receitas/bolo-de-chocolate-facil-e-barato-rspxk8nc.jpg',
                      title: 'Chocolate',
                      author: 'Ryan Gosling',
                      readingTime: 2,
                      cookingTime: 35,
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
          FloatingNavigationBar(currentIndex: 0),
        ],
      ),
    );
  }
}
