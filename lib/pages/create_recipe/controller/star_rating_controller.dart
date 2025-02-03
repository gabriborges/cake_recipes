import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StarRatingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var rating = 0.0.obs;

  Future<void> addRating(String recipeId, int stars) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference recipeDoc =
          _firestore.collection('recipes').doc(recipeId);
      DocumentSnapshot recipeSnapshot = await recipeDoc.get();

      if (recipeSnapshot.exists) {
        Map<String, dynamic> starsMap =
            Map<String, dynamic>.from(recipeSnapshot['stars_list']);
        String userId = user.uid;

        // Add or update the user's rating
        starsMap[userId] = stars;
        await recipeDoc.update({'stars_list': starsMap});
        calculateRating(recipeId);
        Get.snackbar('Success', 'Avaliação adicionada com sucesso!',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Receita não encontrada',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Error', 'Você precisa estar logado para avaliar',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> calculateRating(String recipeId) async {
    DocumentReference recipeDoc =
        _firestore.collection('recipes').doc(recipeId);
    DocumentSnapshot recipeSnapshot = await recipeDoc.get();

    if (recipeSnapshot.exists) {
      Map<String, dynamic> starsMap =
          Map<String, dynamic>.from(recipeSnapshot['stars_list']);
      if (starsMap.isNotEmpty) {
        double totalStars =
            starsMap.values.fold(0, (sum, stars) => sum + stars);
        double averageRating = totalStars / starsMap.length;
        rating.value = averageRating;
        await recipeDoc.update({'rating': averageRating});
      } else {
        rating.value = 0.0;
        await recipeDoc.update({'rating': 0.0});
      }
    } else {
      Get.snackbar('Error', 'Receita não encontrada',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
