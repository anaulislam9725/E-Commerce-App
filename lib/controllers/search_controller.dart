import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TextEditingController searchEditingController = TextEditingController();
  RxString inputText = ''.obs;

  currentText(val) {
    inputText.value = val;

    update();
  }

 
}
