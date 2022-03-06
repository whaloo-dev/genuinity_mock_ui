import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:flutter/material.dart';

const rootRoute = "/main";

const dashboardPageRoute = "/main/dashboard";
const dashboardPageDisplayName = "Dashboard";
const codesPageRoute = "/main/codes";
const codesPageDisplayName = "Codes";
const settingsPageRoute = "/main/settings";
const settingsPageDisplayName = "Settings";

class MenuItem {
  final String name;
  final String route;
  final IconData iconData;

  bool _isSelected() {
    return menuController.isActive(name) || menuController.isHovering(name);
  }

  Widget icon() {
    return Icon(iconData,
        size: 22, color: _isSelected() ? kDarkColor : kLightGreyColor);
  }

  MenuItem(this.route, this.name, this.iconData);
}

List<MenuItem> siteMenuItems = [
  MenuItem(
    dashboardPageRoute,
    dashboardPageDisplayName,
    Icons.trending_up_rounded,
  ),
  MenuItem(
    codesPageRoute,
    codesPageDisplayName,
    Icons.qr_code_rounded,
  ),
  MenuItem(
    settingsPageRoute,
    settingsPageDisplayName,
    Icons.settings_outlined,
  ),
];
