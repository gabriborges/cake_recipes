import 'package:cake_recipes/pages/home/home_page.dart';
import 'package:cake_recipes/pages/login/login_register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cake_recipes/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RoutesDesktop.loginRegisterPage,
      getPages: RoutesDesktop.pages,
      home: HomePage(),
    );
  }
}
