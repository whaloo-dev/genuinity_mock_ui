import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/local_navigator.dart';
import 'package:whaloo_genuinity/widgets/side_menu.dart';
import 'package:whaloo_genuinity/widgets/top_nav.dart';
import 'package:flutter/material.dart';

Widget smallScreen(GlobalKey<ScaffoldState> key) {
  return Scaffold(
    key: key,
    drawer: const Drawer(child: SideMenu()),
    body: Container(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          topNavigationBar(key),
          Expanded(
            child: Card(
              elevation: 1,
              margin: const EdgeInsets.only(bottom: kSpacing),
              color: Get.theme.scaffoldBackgroundColor,
              child: localNavigator(),
            ),
          ),
        ],
      ),
    ),
  );
}
