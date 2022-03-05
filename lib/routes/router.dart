import 'package:dash_santos/pages/clients/clients.dart';
import 'package:dash_santos/pages/drivers/drivers.dart';
import 'package:dash_santos/pages/overview/overview.dart';
import 'package:dash_santos/routes/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(const OverviewPage());
    case driversPageRoute:
      return _getPageRoute(const DriversPage());
    case clientsPageRoute:
      return _getPageRoute(const ClientsPage());
    default:
      return _getPageRoute(const DriversPage());
  }
}

PageRoute _getPageRoute(Widget pageWidget) {
  return MaterialPageRoute(
    builder: (context) => pageWidget,
  );
}
