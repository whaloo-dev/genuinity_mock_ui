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
      shouldIconPulse: true,
      duration: const Duration(seconds: 3),
      backgroundColor: colorScheme.inverseSurface.withOpacity(0.8),
      messageText: Row(
        children: [
          Text(
            "$text ",
            style: TextStyle(
              color: colorScheme.onInverseSurface,
            ),
          ),
          const SizedBox(width: kSpacing),
          if (onCancel != null)
            ElevatedButton(
              onPressed: () {
                Get.closeAllSnackbars();
                onCancel();
              },
              child: const Text("Cancel"),
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
