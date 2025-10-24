import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final controller = TextEditingController();
  // updateData('name','anaul');
  //  updateData('phone','017*****65');
  updateData({
    required BuildContext context,
    required String key,
    required String value,
  }) {
    CollectionReference collectionData = FirebaseFirestore.instance.collection(
      "users_form_data",
    );
    return collectionData
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
          key: value,
          // "name": nameController?.text,
          // "phone": numberController?.text,
        })
        // ignore: use_build_context_synchronously
        .then((onValue) {
          Fluttertoast.showToast(
            msg: "Successfully Updated",
            toastLength: Toast.LENGTH_SHORT,

            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.greyColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // ignore: use_build_context_synchronously
          Navigator.pop(context);

          update();
        });
  }

  Uint8List? image;
  File? selectedImage;
  Future pickImageFormGallery(context) async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) return;

    selectedImage = File(pickedImage.path);
    image = File(pickedImage.path).readAsBytesSync();
    update();
    Navigator.of(context).pop();
  }

  Future pickImageFormCamera(context) async {
    final returnImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (returnImage == null) return;

    selectedImage = File(returnImage.path);
    image = File(returnImage.path).readAsBytesSync();
    update();
    Navigator.of(context).pop();
  }

}
