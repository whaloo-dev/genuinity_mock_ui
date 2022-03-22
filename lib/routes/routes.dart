import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//Routes
const rootRoute = "/main";
const dashboardPageRoute = "/main/dashboard";
const productsPageRoute = "/main/products";
const codesPageRoute = "/main/codes";
const newCodesPageRoute = "/main/new_code";
const settingsPageRoute = "/main/settings";
const colorsPageRoute = "/main/colors";
const shopifyPageRoute = "/main/shopify";

//Menu Items
final productsPageItem = MainMenuItem(
  productsPageRoute,
  "Codes",
  Icons.qr_code_rounded,
);

final dashboardPageItem = MainMenuItem(
  dashboardPageRoute,
  "Statistics",
  Icons.bar_chart_rounded,
);

final settingsPageItem = MainMenuItem(
  settingsPageRoute,
  "Settings",
  Icons.settings_rounded,
);

final colorsPageItem = MainMenuItem(
  colorsPageRoute,
  "Colors (Dev)",
  Icons.color_lens,
);

final shopifyPageItem = MainMenuItem(
  shopifyPageRoute,
  "Shopify Admin",
  Icons.shopify_rounded,
);

final nonePageItem = MainMenuItem("", "", Icons.not_accessible);

List<MainMenuItem> siteMenuItems = [
  productsPageItem,
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
      size: 22,
    );
  }

  MainMenuItem(this.route, this.name, this.iconData);
}
