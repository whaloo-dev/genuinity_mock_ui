import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/pages/codes/codes.dart';
import 'package:whaloo_genuinity/pages/colors/colors.dart';
import 'package:whaloo_genuinity/pages/dashboard/dashoboard.dart';
import 'package:whaloo_genuinity/pages/groups/groups.dart';
import 'package:whaloo_genuinity/pages/reports/reports.dart';
import 'package:whaloo_genuinity/pages/settings/settings.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case dashboardPageRoute:
      return _standardPageRoute(const DashboardPage());
    case groupsPageRoute:
      return _standardPageRoute(GroupsPage());
    case codesPageRoute:
      return _noTransitionPageRoute(const CodesPage());
    case reportsPageRoute:
      return _standardPageRoute(const ReportsPage());
    case settingsPageRoute:
      return _standardPageRoute(const SettingsPage());
    case colorsPageRoute:
      return _standardPageRoute(const ColorsPage());
    default:
      return _standardPageRoute(GroupsPage());
  }
}

PageRoute _standardPageRoute(Widget pageWidget) {
  return MaterialPageRoute(
    builder: (context) => pageWidget,
  );
}

PageRoute _noTransitionPageRoute(Widget pageWidget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => pageWidget,
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );
}
