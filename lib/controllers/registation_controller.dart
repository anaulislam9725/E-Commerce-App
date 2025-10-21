import 'package:e_commerce_app/ui/user_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RegistretionController extends GetxController {
  RxBool isHide = true.obs;
  void showHide() {
    isHide.value = !isHide.value;
  }
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  signUp(BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      var authCredential = credential.user;

      if (authCredential!.uid.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, UserForm.path);
        emailController.clear();
        passwordController.clear();
      } else {
        Fluttertoast.showToast(msg: "Something is worng");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "The account already exists for that email.",
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}