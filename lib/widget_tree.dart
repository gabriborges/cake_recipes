import 'package:cake_recipes/pages/home/home_page.dart';
import 'package:cake_recipes/pages/login/login_register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cake_recipes/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cake_recipes/auth.dart';

class WidgetTree extends StatefulWidget {
  @override
  _WidgetTreeState createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          return HomePage();
        }
        return LoginRegisterPage();
      },
    );
  }
}
