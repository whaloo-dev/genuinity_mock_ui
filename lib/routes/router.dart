import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/pages/codes/codes.dart';
import 'package:whaloo_genuinity/pages/colors/colors.dart';
import 'package:whaloo_genuinity/pages/dashboard/dashoboard.dart';
import 'package:whaloo_genuinity/pages/products/products.dart';
import 'package:whaloo_genuinity/pages/settings/settings.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case dashboardPageRoute:
      return _getPageRoute(const DashboardPage());
    case productsPageRoute:
      return _getPageRoute(const ProductsPage());
    case codesPageRoute:
      assert(settings.arguments != null);
      assert(settings.arguments is Product);
      Product product = settings.arguments as Product;
      return _getPageRoute(CodesPage(product: product));
    case settingsPageRoute:
      return _getPageRoute(const SettingsPage());
    case colorsPageRoute:
      return _getPageRoute(const ColorsPage());

    default:
      return _getPageRoute(const DashboardPage());
  }
}

PageRoute _getPageRoute(Widget pageWidget) {
  return MaterialPageRoute(
    builder: (context) => pageWidget,
  );
}
