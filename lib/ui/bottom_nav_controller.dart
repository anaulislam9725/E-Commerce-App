import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/cart.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/fovourite.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/home.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavController extends StatefulWidget {
  static final String path = "/BottomNavController";
  const BottomNavController({super.key});

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final pages = [
    HomeScreen(),
    FavouriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  int currentInd = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentInd],
      bottomNavigationBar: Container(
        color: AppColors.whiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: GNav(
            tabBackgroundColor: AppColors.mainColor.withValues(alpha: 0.2),
            backgroundColor: AppColors.whiteColor,
            selectedIndex: currentInd,
            onTabChange: (index) {
              setState(() {
                currentInd = index;
              });
            },
            gap: 8,
            padding: EdgeInsets.all(16.h),
            tabs: [
              GButton(icon: Icons.home_outlined, text: "Home"),
              GButton(icon: Icons.favorite_outline, text: "Favorite"),
              GButton(icon: Icons.add_shopping_cart, text: "Cart"),
              GButton(icon: Icons.person_outline, text: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
