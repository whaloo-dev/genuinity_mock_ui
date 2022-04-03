import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';

Widget codeTileMenu(Code code) {
  return menu(
    items: <PopupMenuItemData>[
      PopupMenuItemData(
        text: "Delete",
        icon: Icons.delete_outline_rounded,
        handler: () {
          codesController.deleteCode(code);
        },
      ),
      PopupMenuItemData(
        text: "Duplicate",
        icon: Icons.copy_rounded,
        handler: () {
          codesCreationController.createFrom(code);
          navigationController.goBack();
        },
      ),
      PopupMenuItemData(
        text: "Print",
        icon: Icons.print_outlined,
        handler: () {
          codesController.export(code);
        },
      ),
    ],
  );
}
