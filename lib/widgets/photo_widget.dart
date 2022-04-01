import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';

Widget photoWidget(String? image, {double? fixedSize}) {
  double size =
      fixedSize ?? (Responsiveness.isScreenSmall() ? kSmallImage : kLargeImage);
  return Card(
    color: Colors.transparent,
    elevation: 0,
    clipBehavior: Clip.antiAlias,
    child: SizedBox(
      width: size,
      height: size,
      child: image == null
          ? Container()
          : Image.network(
              image,
              fit: BoxFit.scaleDown,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.image_not_supported_rounded,
              ),
            ),
    ),
  );
}
