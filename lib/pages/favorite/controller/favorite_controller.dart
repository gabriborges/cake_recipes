import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var favoriteRecipes = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavoriteRecipes();
  }

  Future<void> addRecipeToFavorites(String recipeId) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      await userDoc.update({
        'favorite_recipes': FieldValue.arrayUnion([recipeId])
      });
      favoriteRecipes.add(recipeId);
      Get.snackbar('Success', 'Receita adicionada aos favoritos!',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar(
          'Error', 'Você precisa estar logado para adicionar favoritos',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> removeRecipeFromFavorites(String recipeId) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      await userDoc.update({
        'favorite_recipes': FieldValue.arrayRemove([recipeId])
      });
      favoriteRecipes.remove(recipeId);
      Get.snackbar('Success', 'Receita removida dos favoritos!',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Error', 'Você precisa estar logado para remover favoritos',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> fetchFavoriteRecipes() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        List<dynamic> favorites = userDoc['favorite_recipes'];
        favoriteRecipes.value = List<String>.from(favorites);
      }
    } else {
      // Get.snackbar('Error', 'Você precisa estar logado para ver favoritos',
      //     snackPosition: SnackPosition.BOTTOM);
    }
  }

  bool isFavorite(String recipeId) {
    return favoriteRecipes.contains(recipeId);
  }

  Future<void> toggleFavoriteStatus(String recipeId) async {
    if (isFavorite(recipeId)) {
      await removeRecipeFromFavorites(recipeId);
    } else {
      await addRecipeToFavorites(recipeId);
    }
  }

  Future<Map<String, dynamic>?> fetchRecipeDetails(String recipeId) async {
    try {
      DocumentSnapshot recipeDoc =
          await _firestore.collection('recipes').doc(recipeId).get();
      if (recipeDoc.exists) {
        return recipeDoc.data() as Map<String, dynamic>;
      } else {
        Get.snackbar('Error', 'Receita não encontrada',
            snackPosition: SnackPosition.BOTTOM);
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'Falha ao buscar detalhes da receita: $e',
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }
}
