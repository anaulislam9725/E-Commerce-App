
import 'package:e_commerce_app/ui/bottom_nav_controller.dart';
import 'package:e_commerce_app/ui/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainController extends StatefulWidget {
  static final String path = "/MainController";
  const MainController({super.key});

  @override
  State<MainController> createState() => _MainControllerState();
}

class _MainControllerState extends State<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomNavController();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
