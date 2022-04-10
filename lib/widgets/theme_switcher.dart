import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final isDark = menuController.theme().brightness == Brightness.dark;
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isDark ? Icons.light_mode : Icons.light_mode_outlined,
              size: 20,
            ),
            Switch(
              value: isDark,
              onChanged: (isDark) {
                if (isDark) {
                  menuController.changeTheme(darkThemeData);
                } else {
                  menuController.changeTheme(lightThemeData);
                }
              },
            ),
            Icon(
              isDark ? Icons.dark_mode_outlined : Icons.dark_mode,
              size: 20,
            ),
          ],
        );
      },
    );
  }
}
