import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';

Future<void> copyToClipBoard(String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  showActionDoneNotification("Copied to clipboard");
}
