import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/controllers/products_controller.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
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

  Widget _productTileBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Icon(
              Icons.qr_code_rounded,
              size: 16,
              color: kDarkColor,
            ),
            SizedBox(width: kSpacing),
            Text(
              "${Responsiveness.formatNumber(context, product.codesCount)}"
              " code${product.codesCount == 1 ? '' : 's'}",
              style: TextStyle(
                color: kDarkColor,
              ),
            ),
          ],
        ),
        SizedBox(height: kSpacing * 2),
        Row(
          children: [
            Card(
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                product.image,
                width: 100,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.broken_image_rounded,
                  color: kLightGreyColor,
                ),
              ),
            ),
            SizedBox(width: kSpacing),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          product.title,
                          style: TextStyle(color: kDarkColor.withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: kSpacing),
                  Row(
                    children: [
                      Icon(
                        Icons.warehouse_rounded,
                        size: 15,
                        color: kLightGreyColor,
                      ),
                      SizedBox(width: kSpacing),
                      Text(
                        "Inventory : ${Responsiveness.formatNumber(context, product.inventoryQuantity)}",
                        style: TextStyle(
                          color: kLightGreyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2 * kSpacing),
        Row(
          children: [
            Expanded(child: Container()),
            Text(
              "$productIndex / $productsCount",
              style: TextStyle(
                color: kLightGreyColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

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
}
