import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class NewCodesHeader extends StatelessWidget {
  final Product product;

  const NewCodesHeader({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //this will avoid selected CodeTiles to show outside card borders:
        Positioned.fill(
          child: Container(
              // color: kLightColor,
              ),
        ),
        Card(
          margin: const EdgeInsets.all(0),
          // color: kHeaderColor,
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
        )
      ],
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
