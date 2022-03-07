import 'package:flutter/widgets.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/routes/router.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: productsPageRoute,
      onGenerateRoute: generateRoute,
    );
