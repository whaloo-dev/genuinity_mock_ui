import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';

Widget codesMenu(Code code) {
  final _menuItems = <PopupMenuItemData>[
    // _MenuItem(
    //     text: "Hide this product",
    //     icon: Icons.visibility_off_rounded,
    //     handler: () {
    //     },
    //   ),
  ];

  return PopupMenuButton<PopupMenuItemData>(
    onSelected: (item) => item.handler(),
    elevation: kElevation,
    icon: const Icon(
      Icons.more_vert_rounded,
      // color: kDarkColor,
    ),
    itemBuilder: (context) => _menuItems
        .map(
          (menuItem) => PopupMenuItem(
            value: menuItem,
            child: Row(
              children: [
                Icon(menuItem.icon),
                const SizedBox(width: kSpacing),
                Text(menuItem.text),
              ],
            ),
          ),
        )
        .toList(),
  );
}
