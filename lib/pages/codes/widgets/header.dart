import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';

class CodesHeader extends StatelessWidget {
  final Product product;

  const CodesHeader({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kSpacing),
                leading: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.arrow_circle_right_rounded,
                    color: colorScheme.primary.withOpacity(0.4),
                  ),
                ),
                title: _productTileBody(),
                // TODO Add global menu to achieve bulk operations : delete and export
                // trailing: productsMenu(product),
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
        )
      ],
    );
  }

  Widget _productTileBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            _productPhotoWidget(),
            const SizedBox(width: kSpacing),
            Expanded(
              child: _productTitleWidget(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _productPhotoWidget() {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: Responsiveness.isScreenSmall() ? kSmallImage : kLargeImage,
        height: Responsiveness.isScreenSmall() ? kSmallImage : kLargeImage,
        child: Image.network(
          product.image,
          isAntiAlias: true,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.image_not_supported_rounded,
          ),
        ),
      ),
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
          ),
        ),
      ],
    );
  }
}
