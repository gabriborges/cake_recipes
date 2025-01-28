import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var userName = ''.obs;
  var userAge = 0.obs;
  var userRating = 0.0.obs;
  var userRecipes = 0.obs;
  var userReviews = 0.obs;
  var userViews = 0.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkUserProfile();
  }

  Future<void> checkUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (!userDoc.exists) {
        // Navigate to update profile page if user does not exist in Firestore
        Get.offNamed('/updateProfilePage');
      } else {
        // Load user data
        userName.value = userDoc['name'];
        userAge.value = userDoc['age'];
        userRating.value = userDoc['rating'];
        userRecipes.value = userDoc['recipes'];
        userReviews.value = userDoc['reviews'];
        userViews.value = userDoc['views'];
        isLoading.value = false;
      }
    } else {
      // Handle user not logged in
      Get.offNamed('/loginRegisterPage');
    }
  }

  Future<void> updateUserProfile(String name) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'rating': 4.9, // Default rating
        'recipes': 3, // Default number of recipes
        'reviews': 947, // Default number of reviews
        'views': 10000, // Default number of views
      });
      userName.value = name;

      // Navigate to profile page
      Get.offNamed('/profilePage');
    }
  }
}
