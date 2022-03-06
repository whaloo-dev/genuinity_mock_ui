import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/routes/router.dart';
import 'package:whaloo_genuinity/routes/routes.dart';
import 'package:flutter/widgets.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: codesPageRoute,
      onGenerateRoute: generateRoute,
    );
