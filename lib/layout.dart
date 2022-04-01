import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/widgets/large_screen.dart';
import 'package:whaloo_genuinity/widgets/small_screen.dart';
import 'package:flutter/material.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SiteLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        largeWidget: largeScreen(scaffoldKey),
        smallWidget: smallScreen(scaffoldKey),
      ),
    );
  }
}
