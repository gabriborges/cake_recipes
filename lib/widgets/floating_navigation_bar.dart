import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cake_recipes/routes/routes.dart';

class FloatingNavigationBar extends StatelessWidget {
  final int currentIndex;

  FloatingNavigationBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 15.0,
      left: 40.0,
      right: 40.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            fixedColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              switch (index) {
                case 0:
                  Get.offNamed(RoutesDesktop.homePage);
                  break;
                case 1:
                  Get.offNamed(RoutesDesktop.searchPage);
                  break;
                case 2:
                  Get.offNamed(RoutesDesktop.favoritePage);
                  break;
                case 3:
                  Get.offNamed(RoutesDesktop.profilePage);
                  break;
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
