import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/pages/products/widgets/products_menu.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final int productIndex;
  final int productsCount;
  final int vendorsCount;
  final int productTypesCount;

  const ProductTile({
    Key? key,
    required this.product,
    required this.productIndex,
    required this.productsCount,
    required this.vendorsCount,
    required this.productTypesCount,
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
        _qrCodesWidget(),
        SizedBox(height: kSpacing * 2),
        Row(
          children: [
            _productPhotoWidget(context),
            SizedBox(width: kSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _productTitleWidget(),
                  SizedBox(height: kSpacing * 2),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: kSpacing,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (productTypesCount > 1 && product.type.isNotEmpty)
                        _productTypeWidget(),
                      if (vendorsCount > 1 && product.vendor.isNotEmpty)
                        _vendorWidget(),
                      _productInventoryWidget(),
                      _productStatusWidget(),
                      const SizedBox(),
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
            _footerWidget(),
          ],
        ),
      ],
    );
  }

  Widget _qrCodesWidget() {
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

  Widget _productPhotoWidget(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        product.image,
        width: Responsiveness.isScreenSmall(context) ? 75 : 150,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.broken_image_rounded,
          color: kLightGreyColor,
        ),
      ),
    );
  }

  Widget _productTitleWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            product.title,
            style: TextStyle(color: kDarkColor.withOpacity(0.8)),
          ),
        ),
      ],
    );
  }

  Widget _productInventoryWidget() {
    return Container(
      margin: EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FontAwesomeIcons.boxes,
            size: 13,
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
      ),
    );
  }

  Widget _productTypeWidget() {
    return Container(
      margin: EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FontAwesomeIcons.solidFolder,
            size: 13,
            color: kLightGreyColor,
          ),
          SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              product.type,
              style: TextStyle(
                color: kLightGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _vendorWidget() {
    return Container(
      margin: EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FontAwesomeIcons.store,
            size: 13,
            color: kLightGreyColor,
          ),
          SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "Vendor : ${product.vendor}",
              style: TextStyle(
                color: kLightGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productStatusWidget() {
    return Container(
      margin: EdgeInsets.all(kSpacing),
      child: Chip(
        backgroundColor: product.status.color(),
        label: Text(
          product.status.name(),
          style: TextStyle(
            color: kLightGreyColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _footerWidget() {
    return Text(
      "${numberFormat.format(productIndex)} of ${numberFormat.format(productsCount)}",
      style: TextStyle(
        color: kLightGreyColor,
        fontSize: 12,
      ),
    );
  }
}
