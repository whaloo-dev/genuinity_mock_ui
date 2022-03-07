import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/controllers/globals_controller.dart';
import 'package:whaloo_genuinity/controllers/menu_controller.dart';
import 'package:whaloo_genuinity/controllers/navigation_controller.dart';
import 'package:whaloo_genuinity/controllers/store_controller.dart';
import 'package:whaloo_genuinity/layout.dart';
import 'package:whaloo_genuinity/pages/errors/error_404.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

Future<void> main() async {
  Get.put(MenuController());
  Get.put(NavigationController());
  Get.put(GlobalsController());
  Get.put(StoreController());
  runApp(const MyApp());
  await storeController.loadDemoStoreData();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "${globals.appName} v${globals.appVersion}",
      theme: themeData,
      initialRoute: rootRoute,
      unknownRoute: GetPage(
        name: "/404",
        page: () => const PageNotFound(),
        transition: Transition.fadeIn,
      ),
      getPages: [
        GetPage(
          name: rootRoute,
          page: () => SiteLayout(),
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}
