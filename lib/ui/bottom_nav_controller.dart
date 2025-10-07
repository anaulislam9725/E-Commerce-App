import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/cart.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/fovourite.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/home.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/profile.dart';
import 'package:flutter/material.dart';

class BottomNavController extends StatefulWidget {
  static final String path = "/BottomNavController";
  const BottomNavController({super.key});

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final pages = [
    HomeScreen(),
    FovouriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  int currentInd = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "E-Commerce",
          style: Styles.mediumTitle.copyWith(color: AppColors.blackColor),
        ),
        centerTitle: true,
      ),
      body: pages[currentInd],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentInd = index;
          });
        },
        elevation: 5,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.blackColor,
        selectedLabelStyle: Styles.bodySmall.copyWith(
          color: AppColors.blackColor,
        ),
        currentIndex: currentInd,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Fovourite",
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: "Cart",
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            backgroundColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
