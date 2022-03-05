import 'package:dash_santos/constants/style.dart';
import 'package:dash_santos/helpers/local_navigator.dart';
import 'package:dash_santos/widgets/side_menu.dart';
import 'package:dash_santos/widgets/top_nav.dart';
import 'package:flutter/material.dart';

Widget smallScreen(BuildContext context, GlobalKey<ScaffoldState> key) {
  return Scaffold(
    key: key,
    appBar: topNavigationBar(context, key),
    drawer: const Drawer(child: SideMenu()),
    body: Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(kSpacing),
      child: localNavigator(),
    ),
  );
}
