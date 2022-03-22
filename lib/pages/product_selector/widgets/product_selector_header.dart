import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class ProductSelectorHeader extends StatelessWidget {
  const ProductSelectorHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kBorderRadius.topLeft.x),
          topRight: Radius.circular(kBorderRadius.topRight.x),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            dense: true,
            contentPadding: const EdgeInsets.all(kSpacing),
            title: _title(context),
            trailing: _closeWidget(),
          ),
        ],
      ),
    );
  }

  Widget _title(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: kSpacing),
      child: Text(
        "Create Codes",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _closeWidget() {
    return IconButton(
      splashRadius: kIconButtonSplashRadius,
      icon: const Icon(Icons.close_rounded),
      onPressed: () {
        newCodesController.cancel();
      },
    );
  }
}
