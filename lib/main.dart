import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cake_recipes/routes/routes.dart';
import 'package:cake_recipes/widget_tree.dart';
import 'package:cake_recipes/pages/profile/controller/profile_controller.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Get.put(ProfileController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cake Recipes',
      getPages: RoutesDesktop.pages,
      home: WidgetTree(),
    );
  }
}
