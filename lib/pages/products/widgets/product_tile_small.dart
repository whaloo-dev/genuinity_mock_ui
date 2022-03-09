import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/controllers/products_controller.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.start,
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
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: kSpacing * 2),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: Image.network(
                product.image,
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
                        Icons.shopping_cart_rounded,
                        size: 14,
                        color: kLightGreyColor,
                      ),
                      SizedBox(width: kSpacing),
                      Text(
                        "Inventory : ${Responsiveness.formatNumber(context, product.inventoryQuantity)}",
                        style: TextStyle(color: kLightGreyColor, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
