import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/local_navigator.dart';
import 'package:whaloo_genuinity/widgets/side_menu.dart';
import 'package:whaloo_genuinity/widgets/top_nav.dart';
import 'package:flutter/material.dart';

Widget smallScreen(BuildContext context, GlobalKey<ScaffoldState> key) {
  return Scaffold(
    key: key,
    appBar: topNavigationBar(context, key),
    drawer: const Drawer(child: SideMenu()),
    body: Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: kSpacing),
      child: localNavigator(),
    ),
  );
}
