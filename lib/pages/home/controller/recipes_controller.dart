import 'package:cake_recipes/pages/profile/controller/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipesController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var recipes = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
    ProfileController profileController = Get.find<ProfileController>();
    profileController.checkUserProfile();
  }

  Future<void> fetchRecipes() async {
    try {
      isLoading(true);
      QuerySnapshot snapshot = await _firestore.collection('recipes').get();
      recipes.value = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      debugPrint('Failed to fetch recipes: $e');
      // Get.snackbar('Error', 'Failed to fetch recipes: $e',
      //     snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  Future<void> incrementViews(String recipeId) async {
    try {
      DocumentReference recipeDoc =
          _firestore.collection('recipes').doc(recipeId);
      await recipeDoc.update({
        'views': FieldValue.increment(1),
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to increment views: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
