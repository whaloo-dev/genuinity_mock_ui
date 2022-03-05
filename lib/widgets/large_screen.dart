import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/local_navigator.dart';
import 'package:whaloo_genuinity/widgets/side_menu.dart';
import 'package:whaloo_genuinity/widgets/top_nav.dart';
import 'package:flutter/material.dart';

largeScreen(BuildContext context, GlobalKey<ScaffoldState> key) {
  return Row(
    children: [
      const Expanded(child: SideMenu()),
      Expanded(
        flex: 6,
        child: Scaffold(
          appBar: topNavigationBar(context, key),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: kSpacing),
            child: localNavigator(),
          ),
        ),
      ),
    ],
  );
}
