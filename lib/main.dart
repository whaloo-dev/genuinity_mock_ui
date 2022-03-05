import 'package:dash_santos/constants/style.dart';
import 'package:dash_santos/controllers/menu_controller.dart';
import 'package:dash_santos/controllers/navigation_controller.dart';
import 'package:dash_santos/layout.dart';
import 'package:dash_santos/pages/authentication/authentication.dart';
import 'package:dash_santos/pages/errors/error_404.dart';
import 'package:dash_santos/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dash v0.1",
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: kLightColor,
          border: UnderlineInputBorder(
            borderRadius: kBorderRadius,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kActiveColor),
            foregroundColor: MaterialStateProperty.all(kLightColor),
            elevation: MaterialStateProperty.all(kElevation),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: kBorderRadius,
              ),
            ),
          ),
        ),
        cardTheme: CardTheme(
          shadowColor: kDarkColor,
          color: kSurfaceColor,
          elevation: kElevation,
          shape: RoundedRectangleBorder(
            borderRadius: kBorderRadius,
          ),
        ),
        scaffoldBackgroundColor: kLightColor,
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: kDarkColor,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        scrollbarTheme: const ScrollbarThemeData(
          isAlwaysShown: true,
        ),
      ),
      initialRoute: authenticationPageRoute,
      unknownRoute: GetPage(
        name: "/404",
        page: () => const PageNotFound(),
        transition: Transition.fadeIn,
      ),
      getPages: [
        GetPage(name: rootRoute, page: () => SiteLayout()),
        GetPage(
            name: authenticationPageRoute,
            page: () => const AuthenticationPage()),
      ],
    );
  }
}
