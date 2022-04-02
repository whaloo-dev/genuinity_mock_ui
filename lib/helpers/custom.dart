import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';

TextEditingController textEditingController(
    {String? text, TextSelection? selection}) {
  var controller = TextEditingController.fromValue(TextEditingValue(
    text: text ?? "",
    selection: selection ??
        TextSelection.collapsed(offset: text != null ? text.length : 0),
  ));
  return controller;
}

showActionDoneNotification(
  String text, {
  void Function()? onCancel,
}) {
  Get.showSnackbar(
    GetSnackBar(
      duration: const Duration(seconds: 3),
      animationDuration: kAnimationDuration,
      backgroundColor: colorScheme.primaryContainer.withOpacity(0.7),
      barBlur: 1,
      forwardAnimationCurve: Curves.easeInBack,
      reverseAnimationCurve: Curves.easeInBack,
      messageText: Row(
        children: [
          Text(
            "$text ",
            style: TextStyle(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: kSpacing),
          if (onCancel != null)
            TextButton(
              onPressed: () {
                Get.closeAllSnackbars();
                onCancel();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(colorScheme.primaryContainer),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.undo_outlined,
                    color: colorScheme.onPrimaryContainer,
                    size: 15,
                  ),
                  const SizedBox(width: kSpacing),
                  Text(
                    "UNDO",
                    style: TextStyle(color: colorScheme.onPrimaryContainer),
                  )
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

class PopupMenuItemData {
  final String text;
  final IconData icon;
  final void Function() handler;

  PopupMenuItemData({
    required this.text,
    required this.icon,
    required this.handler,
  });
}

Widget menu({required List<PopupMenuItemData> items}) {
  return PopupMenuButton<PopupMenuItemData>(
    onSelected: (item) => item.handler(),
    elevation: kElevation,
    icon: const Icon(
      Icons.more_vert_rounded,
    ),
    itemBuilder: (context) => items
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

Widget dialogLayout(Widget child) {
  return Row(
    children: [
      Expanded(flex: 1, child: Container()),
      Expanded(
        flex: Responsiveness.isScreenSmall()
            ? 100
            : Responsiveness.isScreenMedium()
                ? 10
                : 3,
        child: Column(
          children: [
            const SizedBox(height: kSpacing),
            Expanded(
              child: child,
            ),
            const SizedBox(height: kSpacing),
          ],
        ),
      ),
      Expanded(flex: 1, child: Container()),
    ],
  );
}

Widget stackIcon(
    {required IconData icon1, IconData? icon2, Color? icon2Color}) {
  return Stack(
    children: [
      Container(
        margin: const EdgeInsets.all(7),
        child: Center(
          child: Icon(
            icon1,
            size: 18,
          ),
        ),
      ),
      if (icon2 != null)
        Positioned(
          right: 0,
          child: Icon(
            icon2,
            size: 12,
            color: icon2Color,
          ),
        )
    ],
  );
}

Widget childIndicator() {
  return SizedBox(
    height: kSmallImage,
    width: kSmallImage,
    child: Row(
      children: [
        Expanded(child: Container()),
        Icon(
          Icons.subdirectory_arrow_right_rounded,
          color: colorScheme.outline.withOpacity(0.6),
        ),
      ],
    ),
  );
}
