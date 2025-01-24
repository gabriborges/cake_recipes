import 'package:cake_recipes/pages/create_recipe/create_recipe_page.dart';
import 'package:cake_recipes/pages/favorite/favorite_page.dart';
import 'package:cake_recipes/pages/home/home_page.dart';
import 'package:cake_recipes/pages/login/login_register_page.dart';
import 'package:cake_recipes/pages/profile/profile_page.dart';
import 'package:cake_recipes/pages/recipe/recipe_page';
import 'package:cake_recipes/pages/search/search_page.dart';
import 'package:get/get.dart';

class RoutesDesktop {
  static const homePage = '/homePage';
  static const searchPage = '/searchPage';
  static const favoritePage = '/favoritePage';
  static const profilePage = '/profilePage';
  static const createRecipePage = '/createRecipePage';
  static const recipePage = '/recipePage';
  static const loginRegisterPage = '/LoginRegisterPage';

  static final List<GetPage> pages = [
    GetPage(name: homePage, page: () => HomePage()),
    GetPage(name: searchPage, page: () => SearchPage()),
    GetPage(name: favoritePage, page: () => FavoritePage()),
    GetPage(name: profilePage, page: () => ProfilePage()),
    GetPage(name: createRecipePage, page: () => CreateRecipePage()),
    GetPage(name: recipePage, page: () => RecipePage()),
    GetPage(
        name: loginRegisterPage,
        page: () => LoginRegisterPage()), // Add this line
  ];
}
