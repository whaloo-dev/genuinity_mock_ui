import 'package:dash_santos/constants/controllers.dart';
import 'package:dash_santos/constants/style.dart';
import 'package:dash_santos/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerticalMenuItemWidget extends StatelessWidget {
  final MenuItem menuItem;
  final void Function()? onTap;
  const VerticalMenuItemWidget({Key? key, required this.menuItem, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                  width: 3,
                  height: 72,
                  color: kDarkColor,
                ),
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
