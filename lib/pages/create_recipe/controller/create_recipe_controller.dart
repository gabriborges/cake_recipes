import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CreateRecipeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createRecipe({
    required String authorId,
    required String authorName,
    required int cookingTimeMin,
    required String imageLink,
    required String ingredients,
    required String moreInfo,
    required String preparationMethod,
    required int readingTime,
    required String title,
  }) async {
    try {
      DocumentReference docRef = await _firestore.collection('recipes').add({
        'author_id': authorId,
        'author_name': authorName,
        'cooking_time_min': cookingTimeMin,
        'image_link': imageLink,
        'ingredients': ingredients,
        'more_info': moreInfo,
        'preparation_method': preparationMethod,
        'reading_time_min': readingTime,
        'title': title,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await docRef.update({'id': docRef.id});

      Get.snackbar('Success', 'Receita criada com sucesso!',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Falha ao criar receita: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
