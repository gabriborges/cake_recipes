import 'package:cake_recipes/pages/profile/controller/profile_controller.dart';
import 'package:cake_recipes/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cake_recipes/pages/create_recipe/controller/create_recipe_controller.dart';

class CreateRecipePage extends StatefulWidget {
  @override
  _CreateRecipePageState createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _cookingTimeController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _preparationController = TextEditingController();
  final _additionalInfoController = TextEditingController();
  final _imageLinkController = TextEditingController();
  final _readingTimeController = TextEditingController();
  final CreateRecipeController _createRecipeController =
      Get.put(CreateRecipeController());
  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Receita'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _imageLinkController,
                  decoration: InputDecoration(labelText: 'Link da Imagem'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o link da imagem';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Título'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o título';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _cookingTimeController,
                  decoration:
                      InputDecoration(labelText: 'Tempo de Preparo (minutos)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.parse(value) <= 0) {
                      return 'Por favor, insira um tempo de preparo válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _readingTimeController,
                  decoration:
                      InputDecoration(labelText: 'Tempo de Leitura (minutos)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.parse(value) <= 0) {
                      return 'Por favor, insira um tempo de leitura válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _ingredientsController,
                  decoration: InputDecoration(labelText: 'Ingredientes'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira os ingredientes';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _preparationController,
                  decoration: InputDecoration(labelText: 'Modo de Preparo'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o modo de preparo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _additionalInfoController,
                  decoration: InputDecoration(labelText: 'Mais Informações'),
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      User? user = FirebaseAuth.instance.currentUser;
                      await _profileController.getUserName();
                      if (user != null) {
                        String authorId = user.uid;
                        await _createRecipeController.createRecipe(
                          authorId: authorId,
                          authorName: _profileController.userName.value,
                          cookingTimeMin:
                              int.parse(_cookingTimeController.text),
                          imageLink: _imageLinkController.text,
                          ingredients: _ingredientsController.text,
                          moreInfo: _additionalInfoController.text,
                          preparationMethod: _preparationController.text,
                          readingTime: int.parse(_readingTimeController.text),
                          title: _titleController.text,
                        );
                        Get.toNamed(RoutesDesktop.homePage);
                      } else {
                        Get.snackbar('Error',
                            'Você precisa estar logado para criar uma receita',
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        'Criar',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
