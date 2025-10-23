import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/ui/bottom_nav_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserFormController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genterController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final readonly = true;
  List<String> gender = ["Male", "Female", "Other"];

  Future<void> selectDateFormPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );

    if (picked != null)
      dateOfBirthController.text =
          "${picked.day}/${picked.month}/${picked.year}";
  }

  sendUserDataToDB(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef = FirebaseFirestore.instance.collection(
      "users_form_data",
    );
    return collectionRef
        .doc(currentUser!.email)
        .set({
          "name": nameController.text,
          "phone": numberController.text,
          "dob": dateOfBirthController.text,
          "gender": genterController.text,
          "age": ageController.text,
          
        })
        .then(
          // ignore: use_build_context_synchronously
          (value) => Navigator.pushNamed(context, BottomNavScreen.path),
        
        );
        
  }
}
