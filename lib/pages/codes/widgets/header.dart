import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/global_menu.dart';
import 'package:whaloo_genuinity/widgets/photo_widget.dart';

class CodesHeader extends StatelessWidget {
  final Product product;

  final Color color = Get.theme.colorScheme.primary;
  final Color onColor = Get.theme.colorScheme.onPrimary;

  CodesHeader({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kBorderRadius.topLeft.x),
          topRight: Radius.circular(kBorderRadius.topRight.x),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: kSpacing),
            title: _productTileBody(),
            trailing: codesMenu(product, iconColor: onColor),
            onTap: () {
              navigationController.goBack();
            },
            subtitle: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: kSpacing,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [],
            ),
          ),
        ],
      ),
    );
  }

  Widget _productTileBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              color: onColor,
            ),
            photoWidget(product.image, fixedSize: kSmallImage),
            const SizedBox(width: kSpacing),
            Expanded(
              child: _productTitleWidget(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _productTitleWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Text(
            product.title,
            style: TextStyle(
              color: onColor,
            ),
          ),
        ),
      ],
    );
  }
}
