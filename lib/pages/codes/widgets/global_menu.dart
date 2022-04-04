import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';

Widget codesMenu(Product product) {
  return Obx(
    () => menu(
      items: <PopupMenuItemData>[
        if (codesController.selection().isNotEmpty)
          PopupMenuItemData(
            text: "Unselect All",
            icon: Icons.check_box_outlined,
            handler: () {
              codesController.unselectAll();
            },
          ),
        if (codesController.selection().length != codesController.codesCount())
          PopupMenuItemData(
            text: "Select All",
            icon: Icons.check_box_outline_blank_rounded,
            handler: () {
              codesController.selectAll();
            },
          ),
        if (codesController.selection().isNotEmpty)
          PopupMenuItemData(isDivider: true),
        if (codesController.selection().isNotEmpty)
          PopupMenuItemData(
            text: "Delete (${codesController.selection().length})",
            icon: Icons.delete_outline_rounded,
            handler: () {
              codesController.deleteSelection();
            },
          ),
        if (codesController.selection().isNotEmpty)
          PopupMenuItemData(
            text: "Print (${codesController.selection().length})",
            icon: Icons.print_outlined,
            handler: () {
              codesController.printSelection();
            },
          ),
      ],
    ),
  );
}
