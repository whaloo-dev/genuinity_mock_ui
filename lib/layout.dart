import 'package:dash_santos/helpers/responsiveness.dart';
import 'package:dash_santos/widgets/large_screen.dart';
import 'package:dash_santos/widgets/small_screen.dart';
import 'package:flutter/material.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SiteLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        largeWidget: largeScreen(context, scaffoldKey),
        smallWidget: smallScreen(context, scaffoldKey),
      ),
    );
  }
}
