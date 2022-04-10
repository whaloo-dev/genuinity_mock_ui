import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/routes/routes.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  final _activeItem = productsPageItem.obs;
  final _hoverItem = nonePageItem.obs;
  final _themeData = lightThemeData.obs;

  changeActiveItemTo(MainMenuItem item) {
    _activeItem.value = item;
  }

  activeItem() => _activeItem.value;

  changeTheme(ThemeData mode) {
    _themeData.value = mode;
  }

  onHover(MainMenuItem item) {
    if (!isActive(item)) {
      _hoverItem.value = item;
    }
  }

  isActive(MainMenuItem item) => _activeItem.value == item;

  isHovering(MainMenuItem item) => _hoverItem.value == item;

  ThemeData theme() => _themeData.value;
}
