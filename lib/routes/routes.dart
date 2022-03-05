import 'package:dash_santos/constants/controllers.dart';
import 'package:dash_santos/constants/style.dart';
import 'package:flutter/material.dart';

const rootRoute = "/home";

const overviewPageRoute = "/overview";
const overviewPageDisplayName = "Overview";
const driversPageRoute = "/drivers";
const driversPageDisplayName = "Drivers";
const clientsPageRoute = "/clients";
const clientsPageDisplayName = "Clients";
const authenticationPageRoute = "/auth";
const authenticationPageDisplayName = "Log Out";

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
    overviewPageRoute,
    overviewPageDisplayName,
    Icons.trending_up_rounded,
  ),
  MenuItem(
    driversPageRoute,
    driversPageDisplayName,
    Icons.drive_eta_rounded,
  ),
  MenuItem(
    clientsPageRoute,
    clientsPageDisplayName,
    Icons.people_alt_rounded,
  ),
  MenuItem(authenticationPageRoute, authenticationPageDisplayName,
      Icons.logout_rounded),
];
