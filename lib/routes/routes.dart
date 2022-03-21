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
final productsPageItem = MenuItem(
  productsPageRoute,
  "Codes",
  Icons.qr_code_rounded,
);

final dashboardPageItem = MenuItem(
  dashboardPageRoute,
  "Statistics",
  Icons.bar_chart_rounded,
);

final settingsPageItem = MenuItem(
  settingsPageRoute,
  "Settings",
  Icons.settings_rounded,
);

final colorsPageItem = MenuItem(
  colorsPageRoute,
  "Colors (Dev)",
  Icons.color_lens,
);

final shopifyPageItem = MenuItem(
  shopifyPageRoute,
  "Shopify Admin",
  Icons.shopify_rounded,
);

final nonePageItem = MenuItem("", "", Icons.not_accessible);

List<MenuItem> siteMenuItems = [
  productsPageItem,
  dashboardPageItem,
  settingsPageItem,
  if (kDebugMode) colorsPageItem,
  if (kIsWeb) shopifyPageItem,
];

class MenuItem {
  final String name;
  final String route;
  final IconData iconData;

  Widget icon() {
    return Icon(
      iconData,
      size: 22,
    );
  }

  MenuItem(this.route, this.name, this.iconData);
}
