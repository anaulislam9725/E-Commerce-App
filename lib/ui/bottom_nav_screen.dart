import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/controllers/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavScreen extends StatefulWidget {
  static final String path = "/BottomNavController";
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController2 = Get.put(
      BottomNavController(),
    );
    return Scaffold(
      body: Obx(
        () =>
            bottomNavController2.pages[bottomNavController2.currentIndex.value],
      ),

      bottomNavigationBar: Container(
        color: AppColors.whiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: GNav(
            tabBackgroundColor: AppColors.mainColor.withValues(alpha: 0.2),
            backgroundColor: AppColors.whiteColor,
            selectedIndex: bottomNavController2.currentIndex.value,
            onTabChange: (index) {
              bottomNavController2.pageRoute(index);
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
