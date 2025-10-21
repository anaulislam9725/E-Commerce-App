import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  void deleteCart(BuildContext context, DocumentSnapshot documentSnapshot) {
    FirebaseFirestore.instance
        .collection("users-cart-items")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .doc(documentSnapshot.id)
        .delete()
        .then((onValue) {
          Fluttertoast.showToast(
            msg: "Deleted..",
            toastLength: Toast.LENGTH_SHORT,

            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.greyColor,
            textColor: AppColors.whiteColor,
            fontSize: 16.0,
          );
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        });
    update();
  }
}
