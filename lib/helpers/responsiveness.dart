import 'package:flutter/widgets.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';

const int largeScreenSize = 1366;
const int mediumScreenSize = 768;
const int smallScreenSize = 360;
const int customScreenSize = 1110;

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget(
      {Key? key,
      required this.largeWidget,
      this.mediumWidget,
      this.smallWidget})
      : super(key: key);

  final Widget largeWidget;
  final Widget? mediumWidget;
  final Widget? smallWidget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // double _width = constraints.maxWidth;
        double _width = MediaQuery.of(context).size.width;
        if (_width >= largeScreenSize) {
          return largeWidget;
        } else if (_width < largeScreenSize && _width >= mediumScreenSize) {
          return mediumWidget ?? largeWidget;
        } else {
          return smallWidget ?? largeWidget;
        }
      },
    );
  }
}

class Responsiveness {
  static bool isScreenSmall(BuildContext context) =>
      MediaQuery.of(context).size.width < mediumScreenSize;
  static bool isScreenMedium(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumScreenSize &&
      MediaQuery.of(context).size.width < largeScreenSize;
  static bool isScreenLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= largeScreenSize;
  static bool isScreenCustom(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumScreenSize &&
      MediaQuery.of(context).size.width < customScreenSize;

  static String formatDate(BuildContext context, DateTime dateTime) =>
      isScreenLarge(context)
          ? dateTimeFormat.format(dateTime)
          : compactDateFormat.format(dateTime);

  static String formatNumber(BuildContext context, num number) =>
      isScreenSmall(context)
          ? compactNumberFormat.format(number)
          : numberFormat.format(number);
}
