import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class ProductsMenu extends StatelessWidget {
  const ProductsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PopupMenuButton<Widget>(
          elevation: kElevation,
          shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
          icon: const Icon(Icons.more_vert_rounded),
          itemBuilder: (context) => <PopupMenuItem<Widget>>[
            const PopupMenuItem(child: Text("Action1")),
            const PopupMenuItem(child: Text("Action2")),
            const PopupMenuItem(child: Text("Action3")),
          ],
        ),
      ],
    );
  }
}
