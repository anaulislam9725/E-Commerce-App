import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  RxInt currentValue = 1.obs;
  increament() {
    currentValue++;
  }

  decrement() {
    currentValue--;
  }

  RxInt dotPosition = 0.obs;
  position(val, carouselPageChanged) {
    dotPosition.value = val;
  }

  Future addToCart(dynamic widget) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("users-cart-items");
    return collectionReference
        .doc(currentUser?.email)
        .collection("items")
        .doc()
        .set({
          "name": widget.allProduct["product-name"],
          "price": widget.allProduct["product-price"],
          "image": widget.allProduct["product-image"],
        })
        .then(
          (onValue) => {
            Fluttertoast.showToast(
              msg: "Successfully added",
              toastLength: Toast.LENGTH_SHORT,

              backgroundColor: AppColors.greyColor,
              textColor: Colors.white,
              fontSize: 16.0,
            ),
          },
        );
  }

  Future addToFavourite(dynamic widget) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("users-fovourite-items");
    return collectionReference
        .doc(currentUser?.email)
        .collection("items")
        .doc()
        .set({
          "name": widget.allProduct["product-name"],
          "price": widget.allProduct["product-price"],
          "image": widget.allProduct["product-image"],
        })
        .then(
          (onValue) => {
            Fluttertoast.showToast(
              msg: "Successfully added",
              toastLength: Toast.LENGTH_SHORT,

              backgroundColor: AppColors.greyColor,
              textColor: Colors.white,
              fontSize: 16.0,
            ),
          },
        );
  }
}
