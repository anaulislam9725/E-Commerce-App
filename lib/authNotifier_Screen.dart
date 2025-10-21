import 'package:e_commerce_app/ui/bottom_nav_screen.dart';
import 'package:e_commerce_app/ui/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthNotifierScreen extends StatefulWidget {
  static final String path = "/MainController";
  const AuthNotifierScreen({super.key});

  @override
  State<AuthNotifierScreen> createState() => _AuthNotifierScreenState();
}

class _AuthNotifierScreenState extends State<AuthNotifierScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomNavScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
