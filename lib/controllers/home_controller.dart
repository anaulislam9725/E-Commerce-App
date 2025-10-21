import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<String> carouselImages = <String>[].obs;
  var name;
  List products = [];
  RxInt dotPosition = 0.obs;
  position(val, carouselPageChangedReason) {
    dotPosition.value = val;
  }
  // ignore: non_constant_identifier_names

  var firestoreInstance = FirebaseFirestore.instance;

  fatchCarouselImages() async {
    QuerySnapshot qn = await firestoreInstance
        .collection("carusal-slider")
        .get();
    carouselImages.assignAll(qn.docs.map((doc) => doc["image"]));
 update();
    return qn.docs;
   
  }

  getUserName() async {
    var qn = await firestoreInstance
        .collection("users_form_data")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get();
    name = qn["name"] ?? "";
    // return name = qn["name"];
    update();
  }

  fatchProduts() async {
    QuerySnapshot qn = await firestoreInstance.collection("product").get();

    products = qn.docs.map((doc) {
      {
        return {
          "product-name": doc["name"],
          "product-descrioption": doc["product-descrioption"],
          "product-price": doc["price"],
          "product-image": doc["image"],
        };
      }
    }).toList();
    update();
    return qn.docs;
  }
}
