import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/pages/products/widgets/products_menu.dart';

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
        //this will avoid selected CodeTiles to show outside card borders:
        Positioned.fill(
          child: Container(),
        ),
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
                contentPadding: const EdgeInsets.all(kSpacing),
                leading: _backWidget(),
                title: _productTileBody(context),
                trailing: productsMenu(product),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _productTileBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            _productPhotoWidget(context),
            const SizedBox(width: kSpacing),
            Expanded(
              child: _productTitleWidget(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _backWidget() {
    return IconButton(
      splashRadius: kIconButtonSplashRadius,
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () {
        navigationController.goBack();
      },
    );
  }

  Widget _productPhotoWidget(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: Responsiveness.isScreenSmall(context) ? 50 : 70,
        height: Responsiveness.isScreenSmall(context) ? 50 : 70,
        child: Image.network(
          product.image,
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
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
