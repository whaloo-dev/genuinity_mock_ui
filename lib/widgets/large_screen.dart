import 'package:dash_santos/constants/style.dart';
import 'package:dash_santos/helpers/local_navigator.dart';
import 'package:dash_santos/widgets/side_menu.dart';
import 'package:dash_santos/widgets/top_nav.dart';
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
