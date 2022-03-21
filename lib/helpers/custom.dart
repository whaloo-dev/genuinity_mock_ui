import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/style.dart';

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
      backgroundColor: kDarkColor.withOpacity(0.8),
      messageText: Row(
        children: [
          Text(
            "$text ",
            style: const TextStyle(color: kSurfaceColor),
          ),
          const SizedBox(width: kSpacing),
          if (onCancel != null)
            ElevatedButton(
              onPressed: () {
                Get.closeAllSnackbars();
                onCancel();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: kLightColor),
              ),
            ),
        ],
      ),
    ),
  );
}
