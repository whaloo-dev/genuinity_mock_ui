import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/demo_backend.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/globals.dart';
import 'package:whaloo_genuinity/controllers/codes_controller.dart';
import 'package:whaloo_genuinity/controllers/creation_controller.dart';
import 'package:whaloo_genuinity/controllers/detail_controller.dart';
import 'package:whaloo_genuinity/controllers/filtering_controller.dart';
import 'package:whaloo_genuinity/controllers/groups_controller.dart';
import 'package:whaloo_genuinity/controllers/menu_controller.dart';
import 'package:whaloo_genuinity/controllers/navigation_controller.dart';
import 'package:whaloo_genuinity/controllers/products_selector_controller.dart';
import 'package:whaloo_genuinity/controllers/store_controller.dart';
import 'package:whaloo_genuinity/layout.dart';
import 'package:whaloo_genuinity/pages/errors/error_404.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

void main() {
  // ignore: unnecessary_cast
  Get.put(DemoBackend() as Backend);
  Get.put(MenuController());
  Get.put(NavigationController());
  Get.put(StoreController());
  Get.put(GroupsController());
  Get.put(CodesController());
  Get.put(CreationController());
  Get.put(DetailController());
  Get.put(ProductsSelectorController());
  Get.put(FilteringController());
  storeController.onReady();
  groupsController.onReady();
  codesController.onReady();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "$appName v$appVersion",
        theme: menuController.theme(),
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
      ),
    );
  }
}
