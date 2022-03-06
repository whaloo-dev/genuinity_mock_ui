import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/pages/codes/codes.dart';
import 'package:whaloo_genuinity/pages/dashboard/dashoboard.dart';
import 'package:whaloo_genuinity/pages/settings/settings.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case dashboardPageRoute:
      return _getPageRoute(const DashboardPage());
    case codesPageRoute:
      return _getPageRoute(const CodesPage());
    case settingsPageRoute:
      return _getPageRoute(const SettingsPage());
    default:
      return _getPageRoute(const DashboardPage());
  }
}

PageRoute _getPageRoute(Widget pageWidget) {
  return MaterialPageRoute(
    builder: (context) => pageWidget,
  );
}
