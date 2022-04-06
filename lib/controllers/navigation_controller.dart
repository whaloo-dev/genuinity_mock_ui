import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';

class NavigationController extends GetxController {
  static NavigationController instance = Get.find();

  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  Future<dynamic> navigateTo(
    String routeName, {
    Object? arguments,
  }) {
    codesFilteringController.reset();
    return navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  goBack() {
    codesFilteringController.reset();
    return navigationKey.currentState!.pop();
  }

  goHome() {
    codesFilteringController.reset();
    navigationKey.currentState!.popUntil((route) => route.isFirst);
  }
}
