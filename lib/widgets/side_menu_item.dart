import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

class SideMenuItemWidget extends StatelessWidget {
  final MainMenuItem menuItem;
  final void Function()? onTap;

  const SideMenuItemWidget({Key? key, required this.menuItem, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      if (Responsiveness.isScreenSmall()) {
        Navigator.of(context).pop();
      }
      if (onTap != null) {
        onTap!();
      }
    }

    return InkWell(
      onTap: _onTap,
      onHover: (value) {
        value
            ? menuController.onHover(menuItem)
            : menuController.onHover(nonePageItem);
      },
      child: Obx(
        () => Row(
          children: [
            Visibility(
              visible: menuController.isHovering(menuItem) ||
                  menuController.isActive(menuItem),
              child: Container(
                width: 6,
                height: 40,
                color: menuController.theme().colorScheme.onSurface,
              ),
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
            ),
            Expanded(
              child: Flex(
                direction: Responsiveness.isScreenCustom()
                    ? Axis.vertical
                    : Axis.horizontal,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: kSpacing),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: menuItem.icon(menuController.isActive(menuItem)),
                  ),
                  if (!menuController.isActive(menuItem))
                    Flexible(
                      child: Text(menuItem.name),
                    )
                  else
                    Flexible(
                      child: Text(
                        menuItem.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
