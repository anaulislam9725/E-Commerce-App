import 'package:e_commerce_app/authNotifier_Screen.dart';
import 'package:e_commerce_app/ui/bottom_nav_screen.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/cart.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/fovourite.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/home.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/profile.dart';
import 'package:e_commerce_app/ui/forgot_password.dart';
import 'package:e_commerce_app/ui/login_screen.dart';
import 'package:e_commerce_app/ui/payment_successful_screen.dart';
import 'package:e_commerce_app/ui/product.dart';
import 'package:e_commerce_app/ui/product_details_screen.dart';
import 'package:e_commerce_app/ui/registration_screen.dart';
import 'package:e_commerce_app/ui/search_screen.dart';
import 'package:e_commerce_app/ui/splash_screen.dart';
import 'package:e_commerce_app/ui/user_form.dart';
import 'package:flutter/material.dart';

class RoutesHelper {
  static final Map<String, Widget Function(BuildContext)> appRoutes =
      <String, WidgetBuilder>{
        Product.path: (_) => Product(),
        SplashScreen.path: (_) => SplashScreen(),
        LoginScreen.path: (context) => LoginScreen(),
        BottomNavScreen.path: (context) => BottomNavScreen(),
        SignUpScreen.path: (context) => SignUpScreen(),
        UserForm.path: (context) => UserForm(),
        HomeScreen.path: (context) => HomeScreen(),
        FavouriteScreen.path: (context) => FavouriteScreen(),
        CartScreen.path: (context) => CartScreen(),
        ProfileScreen.path: (context) => ProfileScreen(),
        SearchScreen.path: (context) => SearchScreen(),
        DetailsScreen.path: (context) => DetailsScreen(),
        AuthNotifierScreen.path: (context) => AuthNotifierScreen(),
        ForgotPasswordScreen.path: (context) => ForgotPasswordScreen(),
        PaymentSuccessfulScreen.path:(context)=> PaymentSuccessfulScreen(),
      };
}
