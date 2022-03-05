import 'package:dash_santos/constants/controllers.dart';
import 'package:dash_santos/routes/router.dart';
import 'package:dash_santos/routes/routes.dart';
import 'package:flutter/widgets.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: driversPageRoute,
      onGenerateRoute: generateRoute,
    );
