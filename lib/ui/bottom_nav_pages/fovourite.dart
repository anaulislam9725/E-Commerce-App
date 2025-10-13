import 'package:flutter/material.dart';

class FovouriteScreen extends StatefulWidget {
  const FovouriteScreen({super.key});

  @override
  State<FovouriteScreen> createState() => _FovouriteScreenState();
}

class _FovouriteScreenState extends State<FovouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(),
            child: Image.asset("assets/email.png", color: Colors.black),
          ),
        ],
      ),
    );
  }
}
