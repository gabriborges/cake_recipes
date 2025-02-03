import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var userName = ''.obs;
  var userPic = ''.obs;
  var userAge = 0.obs;
  var userRating = 0.0.obs;
  var userRecipes = 0.obs;
  var userReviews = 0.obs;
  var userViews = 0.obs;
  var userProfilePicture = ''.obs;
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
        userPic.value = userDoc['profile_pic'];
        userRating.value = (userDoc['rating'] as num).toDouble();
        userRecipes.value = userDoc['recipes'].length;
        userReviews.value = userDoc['reviews'];
        userViews.value = userDoc['views'];
        userProfilePicture.value = userDoc['profile_pic'];
        updateUserReviews(userDoc['recipes']);
        updateUserRating(userDoc['recipes']);
        isLoading.value = false;
      }
    } else {
      // Handle user not logged in
      // Get.offNamed('/loginRegisterPage');
      print('User not logged in...');
      // Get.offNamed('/loginRegisterPage');
    }
  }

  Future<void> updateUserReviews(List<dynamic> recipeIds) async {
    int totalReviews = 0;
    print('Recipe IDs: $recipeIds');
    for (String recipeId in recipeIds) {
      print('Recipe ID: $recipeId');
      DocumentSnapshot recipeDoc =
          await _firestore.collection('recipes').doc(recipeId).get();
      if (recipeDoc.exists) {
        Map<String, dynamic> starsMap =
            Map<String, dynamic>.from(recipeDoc['stars_list']);
        totalReviews += starsMap.length;
      }
    }
    userReviews.value = totalReviews;
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'reviews': totalReviews,
      });
    }
  }

  Future<void> getUserName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      userName.value = userDoc['name'];
    }
  }

  Future<void> updateUserProfile(String name) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'profile_pic':
            'https://upload.wikimedia.org/wikipedia/commons/8/83/Default-Icon.jpg',
        'rating': 0.0,
        'recipes': 0,
        'reviews': 0,
        'views': 0,
        'favorite_recipes': [],
      });
      userName.value = name;

      // Navigate to profile page
      Get.offNamed('/profilePage');
    }
  }

  Future<void> updateUserRating(List<dynamic> recipeIds) async {
    double totalRating = 0.0;
    int ratedRecipesCount = 0;

    for (String recipeId in recipeIds) {
      DocumentSnapshot recipeDoc =
          await _firestore.collection('recipes').doc(recipeId).get();
      if (recipeDoc.exists) {
        double recipeRating = (recipeDoc['rating'] as num).toDouble();
        totalRating += recipeRating;
        ratedRecipesCount++;
      }
    }

    double averageRating =
        ratedRecipesCount > 0 ? totalRating / ratedRecipesCount : 0.0;
    userRating.value = averageRating;

    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'rating': averageRating,
      });
    }
  }
}
