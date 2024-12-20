import 'package:cake_recipes/home/home_page.dart';
import 'package:get/get.dart';

class RoutesDesktop {
  static const homePage = '/homePage';

  static final List<GetPage> pages = [
    GetPage(name: homePage, page: () => HomePage()),
  ];
}
