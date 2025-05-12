import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreenController extends GetxController {
  Rx<PageController> pageController = PageController().obs;
  RxInt selectedIndex =0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getUser();
  }

  onPageChange(value){
    selectedIndex.value = value;
    update();
  }


}