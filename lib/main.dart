import 'package:e_commerce_app/mainController.dart';
import 'package:e_commerce_app/ui/bottom_nav_controller.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/cart.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/fovourite.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/home.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/profile.dart';
import 'package:e_commerce_app/ui/forgot_password.dart';
import 'package:e_commerce_app/ui/login_screen.dart';
import 'package:e_commerce_app/ui/priduct.dart';
import 'package:e_commerce_app/ui/product_details_screen.dart';
import 'package:e_commerce_app/ui/registration_screen.dart';
import 'package:e_commerce_app/ui/search_screen.dart';
import 'package:e_commerce_app/ui/splash_screen.dart';

import 'package:e_commerce_app/ui/user_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: SplashScreen1.path,
        routes: {
          Product.path:(_)=>Product(),
          SplashScreen1.path:(_)=>SplashScreen1(),
          LoginScreen.path: (context) => LoginScreen(),
          BottomNavController.path: (context) => BottomNavController(),
          SignUpScreen.path: (context) => SignUpScreen(),
          UserForm.path: (context) => UserForm(),
          HomeScreen.path: (context) => HomeScreen(),
          FavouriteScreen.path: (context) => FavouriteScreen(),
          CartScreen.path: (context) => CartScreen(),
          ProfileScreen.path: (context) => ProfileScreen(),
          SearchScreen.path: (context) => SearchScreen(),
          DetailsScreen.path: (context) => DetailsScreen(),
          MainController.path: (context) => MainController(),
          ForgotPasswordScreen.path: (context) => ForgotPasswordScreen(),
        },
      ),
    );
  }
}
