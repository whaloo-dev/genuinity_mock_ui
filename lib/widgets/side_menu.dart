import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/url_launcher.dart';
import 'package:whaloo_genuinity/routes/routes.dart';
import 'package:whaloo_genuinity/widgets/logo.dart';
import 'package:whaloo_genuinity/widgets/side_menu_item.dart';
import 'package:whaloo_genuinity/widgets/theme_switcher.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: kSpacing),
        const Logo(),
        const SizedBox(height: kSpacing),
        const Divider(thickness: 1, height: 1),
        const SizedBox(height: kSpacing),
        Column(mainAxisSize: MainAxisSize.min, children: [
          ...siteMenuItems
              .map(
                (item) => SideMenuItemWidget(
                  menuItem: item,
                  onTap: () {
                    if (item.route == shopifyPageRoute) {
                      goToShopify();
                      return;
                    }
                    menuController.changeActiveItemTo(item);
                    navigationController.goHome();
                    navigationController.navigateTo(item.route);
                  },
                ),
              )
              .toList(),
          ...<Widget>[
            const SizedBox(height: kSpacing),
            const Divider(thickness: 1, height: 1),
            const SizedBox(height: kSpacing),
            const ThemeSwitcher(),
          ],
        ]),
      ],
    );
  }
}
