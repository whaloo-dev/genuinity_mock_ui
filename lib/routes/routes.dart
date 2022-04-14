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
final productsPageItem = MainMenuItem(
  groupsPageRoute,
  "Codes",
  Icons.qr_code_rounded,
  Icons.qr_code_rounded,
);

final dashboardPageItem = MainMenuItem(
  dashboardPageRoute,
  "Dashboard",
  Icons.area_chart_outlined,
  Icons.area_chart,
);

final reportsPageItem = MainMenuItem(
  reportsPageRoute,
  "Reports",
  Icons.flag_outlined,
  Icons.flag,
);

final settingsPageItem = MainMenuItem(
  settingsPageRoute,
  "Settings",
  Icons.settings_outlined,
  Icons.settings,
);

final colorsPageItem = MainMenuItem(
  colorsPageRoute,
  "Colors (Dev)",
  Icons.color_lens_outlined,
  Icons.color_lens,
);

final shopifyPageItem = MainMenuItem(
  shopifyPageRoute,
  "Shopify Admin",
  Icons.shopify_outlined,
  Icons.shopify,
);

final nonePageItem =
    MainMenuItem("", "", Icons.not_accessible, Icons.not_accessible);

List<MainMenuItem> siteMenuItems = [
  dashboardPageItem,
  productsPageItem,
  reportsPageItem,
  settingsPageItem,
  if (kDebugMode) colorsPageItem,
  if (kIsWeb) shopifyPageItem,
];

class MainMenuItem {
  final String name;
  final String route;
  final IconData outlinedIconData;
  final IconData iconData;

  Widget icon(bool selected) {
    if (selected) {
      return Icon(iconData);
    }
    return Icon(
      outlinedIconData,
    );
  }

  MainMenuItem(
    this.route,
    this.name,
    this.outlinedIconData,
    this.iconData,
  );
}
