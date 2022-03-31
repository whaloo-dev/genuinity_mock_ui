import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';

Widget codeTileMenu(Code code) {
  final _menuItems = <PopupMenuItemData>[
    PopupMenuItemData(
      text: "Delete",
      icon: Icons.delete_rounded,
      handler: () {
        codesController.deleteCode(code);
      },
    ),
  ];

  return PopupMenuButton<PopupMenuItemData>(
    onSelected: (item) => item.handler(),
    elevation: kElevation,
    icon: const Icon(
      Icons.more_vert_rounded,
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
