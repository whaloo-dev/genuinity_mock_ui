import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/pages/codes/codes.dart';
import 'package:whaloo_genuinity/pages/colors/colors.dart';
import 'package:whaloo_genuinity/pages/dashboard/dashoboard.dart';
import 'package:whaloo_genuinity/pages/groups/groups.dart';
import 'package:whaloo_genuinity/pages/settings/settings.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case dashboardPageRoute:
      return _getPageRoute(const DashboardPage());
    case groupsPageRoute:
      return _getPageRoute(GroupsPage());
    case codesPageRoute:
      return _noTransitionPageRoute(const CodesPage());
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

PageRoute _noTransitionPageRoute(Widget pageWidget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => pageWidget,
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );
}

// TODO Clean if needed
// PageRoute _getRightSlidePageRoute(Widget pageWidget) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => pageWidget,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(1, 0.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//       final offsetAnimation = animation.drive(tween);
//       return SlideTransition(
//         position: offsetAnimation,
//         child: child,
//       );
//     },
//   );
// }
