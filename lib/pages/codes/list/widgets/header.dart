import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models/product.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/codes/list/widgets/global_menu.dart';
import 'package:whaloo_genuinity/widgets/photo_widget.dart';

class CodesHeader extends StatelessWidget {
  final Product product;

  const CodesHeader({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          color: menuController.theme().colorScheme.primary,
          elevation: 1,
          margin: EdgeInsets.zero,
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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kSpacing),
                title: _productTileBody(),
                trailing: codesMenu(product,
                    iconColor: menuController.theme().colorScheme.onPrimary),
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
        ));
  }

  Widget _productTileBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Obx(() => Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: menuController.theme().colorScheme.onPrimary,
                )),
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
          child: Obx(
            () => Text(
              product.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: menuController.theme().colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
