import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

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
                GestureDetector(
                  onTap: _pickImage,
                  child: _image == null
                      ? Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: Icon(Icons.add_a_photo, size: 50),
                        )
                      : Image.file(File(_image!.path), height: 200),
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
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o tempo de preparo';
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
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
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
                )
                // Center(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       if (_formKey.currentState!.validate()) {
                //
                //       }
                //     },
                //     child: Text('Criar'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
