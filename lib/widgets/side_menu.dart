import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/url_launcher.dart';
import 'package:whaloo_genuinity/routes/routes.dart';
import 'package:whaloo_genuinity/widgets/logo.dart';
import 'package:whaloo_genuinity/widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLightColor,
      child: ListView(children: [
        const SizedBox(height: kSpacing),
        const Logo(),
        const SizedBox(height: kSpacing),
        Divider(color: kLightGreyColor.withOpacity(.2), thickness: 2),
        const SizedBox(height: kSpacing),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: siteMenuItems
              .map(
                (item) => SideMenuItemWidget(
                  menuItem: item,
                  onTap: () {
                    if (item.route == shopifyPageRoute) {
                      goToShopify();
                      return;
                    }
                    menuController.changeActiveItemTo(item);
                    navigationController.navigateTo(item.route);
                  },
                ),
              )
              .toList(),
        )
      ]),
    );
  }
}
