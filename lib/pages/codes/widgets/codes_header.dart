import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
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
          child: Container(
            color: kLightColor,
          ),
        ),
        Card(
          margin: const EdgeInsets.all(0),
          color: kHeaderColor,
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
                trailing: productsMenu(context, product),
              ),
              // const Divider(thickness: 1, height: 1),
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
        width: 75,
        child: Image.network(
          product.image,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.image_not_supported_rounded,
            color: kLightGreyColor,
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
            style: TextStyle(
              color: kDarkColor.withOpacity(0.8),
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
