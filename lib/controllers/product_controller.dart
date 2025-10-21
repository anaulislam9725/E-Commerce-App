import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  List products = [];
  var firestoreInstance = FirebaseFirestore.instance;

  fatchProduts() async {
    QuerySnapshot qn = await firestoreInstance.collection("product").get();

    for (int i = 0; i < qn.docs.length; i++) {
      products.add({
        "product-name": qn.docs[i]["name"],
        "product-descrioption": qn.docs[i]["product-descrioption"],
        "product-price": qn.docs[i]["price"],
        "product-image": qn.docs[i]["image"],
      });
    }
    update();
    return qn.docs;
  }
}
