import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

class SideMenuItemWidget extends StatelessWidget {
  final MenuItem menuItem;
  final void Function()? onTap;

  const SideMenuItemWidget({Key? key, required this.menuItem, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      if (ResponsiveWidget.isScreenSmall(context)) {
        Navigator.of(context).pop();
      }
      if (onTap != null) {
        onTap!();
      }
    }

    // if (ResponsiveWidget.isScreenCustom(context)) {
    //   return VerticalMenuItemWidget(
    //     menuItem: menuItem,
    //     onTap: _onTap,
    //   );
    // }
    // return HorziontalMenuItem(
    //   menuItem: menuItem,
    //   onTap: _onTap,
    // );

    return InkWell(
      onTap: _onTap,
      onHover: (value) {
        value
            ? menuController.onHover(menuItem.name)
            : menuController.onHover("not hovering");
      },
      child: Obx(
        () => Container(
          color: menuController.isHovering(menuItem.name)
              ? kLightGreyColor.withOpacity(.1)
              : Colors.transparent,
          child: Row(
            children: [
              Visibility(
                visible: menuController.isHovering(menuItem.name) ||
                    menuController.isActive(menuItem.name),
                child: Container(
                  width: 6,
                  height: 40,
                  color: kDarkColor,
                ),
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
              ),
              Expanded(
                child: Flex(
                  direction: ResponsiveWidget.isScreenCustom(context)
                      ? Axis.vertical
                      : Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: kSpacing),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: menuItem.icon(),
                    ),
                    if (!menuController.isActive(menuItem.name))
                      Flexible(
                        child: Text(
                          menuItem.name,
                          style: TextStyle(
                            color: menuController.isHovering(menuItem.name)
                                ? kDarkColor
                                : kLightGreyColor,
                          ),
                        ),
                      )
                    else
                      Flexible(
                        child: Text(
                          menuItem.name,
                          style: TextStyle(
                            color: kDarkColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
