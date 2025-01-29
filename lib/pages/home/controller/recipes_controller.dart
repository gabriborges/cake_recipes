import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RecipesController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var recipes = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    try {
      isLoading(true);
      QuerySnapshot snapshot = await _firestore.collection('recipes').get();
      recipes.value = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch recipes: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
