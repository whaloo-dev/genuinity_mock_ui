import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
        double _width = Get.mediaQuery.size.width;
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
  static bool isScreenSmall() => Get.mediaQuery.size.width < mediumScreenSize;
  static bool isScreenMedium() =>
      Get.mediaQuery.size.width >= mediumScreenSize &&
      Get.mediaQuery.size.width < largeScreenSize;
  static bool isScreenLarge() => Get.mediaQuery.size.width >= largeScreenSize;
  static bool isScreenCustom() =>
      Get.mediaQuery.size.width >= mediumScreenSize &&
      Get.mediaQuery.size.width < customScreenSize;

  static String formatDate(DateTime dateTime) => isScreenLarge()
      ? dateTimeFormat.format(dateTime)
      : compactDateFormat.format(dateTime);

  static String formatNumber(num number) => isScreenSmall()
      ? compactNumberFormat.format(number)
      : numberFormat.format(number);
}
