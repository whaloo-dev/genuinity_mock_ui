import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/local_navigator.dart';
import 'package:whaloo_genuinity/widgets/side_menu.dart';
import 'package:whaloo_genuinity/widgets/top_nav.dart';
import 'package:flutter/material.dart';

largeScreen(GlobalKey<ScaffoldState> key) {
  return Row(
    children: [
      const Expanded(child: SideMenu()),
      Expanded(
        flex: 6,
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: kSpacing),
            child: Column(
              children: [
                topNavigationBar(key),
                Expanded(
                  child: Obx(() => Card(
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: kSpacing),
                        color: menuController.theme().colorScheme.surface,
                        child: localNavigator(),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
