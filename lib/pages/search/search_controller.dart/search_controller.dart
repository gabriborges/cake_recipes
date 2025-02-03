import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var searchResults = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  Future<void> searchRecipes(String query) async {
    try {
      isLoading(true);
      List<String> queryWords = query
          .toLowerCase()
          .split(' ')
          .where((word) => word.isNotEmpty)
          .toList();

      QuerySnapshot snapshot = await _firestore.collection('recipes').get();

      searchResults.value = snapshot.docs.where((doc) {
        var data = doc.data() as Map<String, dynamic>;
        var titleSearch = data['search_title'] as List<dynamic>;
        return queryWords.every(
            (word) => titleSearch.any((element) => element.startsWith(word)));
      }).map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return data;
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to search recipes: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
