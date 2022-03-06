import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/routes/routes.dart';
import 'package:whaloo_genuinity/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLightColor,
      child: ListView(children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: kSpacing),
            Container(
              padding: const EdgeInsets.only(right: 12),
              child: Image.asset("assets/icons/logo-small.png"),
            ),
            Flexible(
              child: Text(
                "${globals.appName} v${globals.appVersion}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: kDarkColor.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: kSpacing),
        Divider(color: kLightGreyColor.withOpacity(.2)),
        SizedBox(height: kSpacing),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: siteMenuItems
              .map(
                (item) => SideMenuItemWidget(
                  menuItem: item,
                  onTap: () {
                    if (item.route == authenticationPageRoute) {
                      menuController
                          .changeActiveItemTo(overviewPageDisplayName);
                      Get.offAllNamed(authenticationPageRoute);
                    } else if (!menuController.isActive(item.name)) {
                      menuController.changeActiveItemTo(item.name);
                      navigationController.navigateTo(item.route);
                    }
                  },
                ),
              )
              .toList(),
        )
      ]),
    );
  }
}
