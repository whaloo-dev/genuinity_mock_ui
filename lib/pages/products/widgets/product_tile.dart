import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/controllers/products_controller.dart';
import 'package:whaloo_genuinity/pages/products/widgets/products_menu.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final int productIndex;
  final int productsCount;
  const ProductTile({
    Key? key,
    required this.product,
    required this.productIndex,
    required this.productsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: Colors.transparent,
      dense: true,
      title: _productTileBody(context),
      contentPadding: EdgeInsets.only(
        top: 20,
        left: kSpacing,
        right: kSpacing,
      ),
      trailing: productsMenu(context, product),
      onTap: () {},
    );
  }

  Widget _productTileBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _qrCodesWidget(context),
        SizedBox(height: kSpacing * 2),
        Row(
          children: [
            _photoWidget(context),
            SizedBox(width: kSpacing),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _productTitleWidget(context),
                  SizedBox(height: kSpacing),
                  _productInventoryWidget(context),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2 * kSpacing),
        Row(
          children: [
            Expanded(child: Container()),
            _footerWidget(context),
          ],
        ),
      ],
    );
  }

  Widget _qrCodesWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Icon(
              Icons.qr_code_rounded,
              size: 18,
              color: kDarkColor,
            ),
            SizedBox(width: kSpacing),
            Text(
              "${numberFormat.format(product.codesCount)}"
              " code${product.codesCount == 1 ? '' : 's'}",
              style: TextStyle(
                color: kDarkColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _photoWidget(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        product.image,
        width: 150,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.broken_image_rounded,
          color: kLightGreyColor,
        ),
      ),
    );
  }

  Widget _productTitleWidget(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            product.title,
            style: TextStyle(color: kDarkColor.withOpacity(0.6)),
          ),
        ),
      ],
    );
  }

  Widget _productInventoryWidget(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.warehouse_rounded,
          size: 15,
          color: kLightGreyColor,
        ),
        SizedBox(width: kSpacing),
        Text(
          "Inventory : ${numberFormat.format(product.inventoryQuantity)}",
          style: TextStyle(
            color: kLightGreyColor,
          ),
        ),
      ],
    );
  }

  Widget _footerWidget(BuildContext context) {
    return Text(
      "${numberFormat.format(productIndex)} of ${numberFormat.format(productsCount)}",
      style: TextStyle(
        color: kLightGreyColor,
        fontSize: 12,
      ),
    );
  }
}
