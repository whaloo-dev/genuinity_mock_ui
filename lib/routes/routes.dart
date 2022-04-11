import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//Routes
const rootRoute = "/main";
const dashboardPageRoute = "/main/dashboard";
const groupsPageRoute = "/main/products";
const codesPageRoute = "/main/codes";
const newCodesPageRoute = "/main/new_code";
const reportsPageRoute = "/main/reports";
const settingsPageRoute = "/main/settings";
const colorsPageRoute = "/main/colors";
const shopifyPageRoute = "/main/shopify";

//Menu Items
final productsPageItem =
    MainMenuItem(groupsPageRoute, "Codes", Icons.qr_code_rounded);

final dashboardPageItem =
    MainMenuItem(dashboardPageRoute, "Statistics", Icons.area_chart_outlined);

final reportsPageItem = MainMenuItem(
  reportsPageRoute,
  "Reports",
  Icons.mail_outline_rounded,
);

final settingsPageItem = MainMenuItem(
  settingsPageRoute,
  "Settings",
  Icons.settings_outlined,
);

final colorsPageItem = MainMenuItem(
  colorsPageRoute,
  "Colors (Dev)",
  Icons.color_lens_outlined,
);

final shopifyPageItem = MainMenuItem(
  shopifyPageRoute,
  "Shopify Admin",
  Icons.shopify_outlined,
);

final nonePageItem = MainMenuItem("", "", Icons.not_accessible);

List<MainMenuItem> siteMenuItems = [
  productsPageItem,
  reportsPageItem,
  dashboardPageItem,
  settingsPageItem,
  if (kDebugMode) colorsPageItem,
  if (kIsWeb) shopifyPageItem,
];

class MainMenuItem {
  final String name;
  final String route;
  final IconData iconData;

  Widget icon() {
    return Icon(
      iconData,
    );
  }

  MainMenuItem(this.route, this.name, this.iconData);
}
