import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/pages/code_groups/widgets/products_menu.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final int productIndex;
  final int productsCount;
  final int vendorsCount;
  final int productTypesCount;
  final void Function(Product product) onSelected;

  const ProductTile({
    Key? key,
    required this.onSelected,
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
      title: _productTileBody(context),
      onTap: () {
        onSelected(product);
      },
    );
  }

  Widget _productTileBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _qrCodesWidget(),
        const SizedBox(height: kSpacing * 2),
        Row(
          children: [
            _productPhotoWidget(context),
            const SizedBox(width: kSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _productTitleWidget(),
                  const SizedBox(height: kSpacing * 2),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: kSpacing,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      (productTypesCount > 1 && product.type.isNotEmpty)
                          ? _productTypeWidget()
                          : const SizedBox(),
                      (vendorsCount > 1 && product.vendor.isNotEmpty)
                          ? _vendorWidget()
                          : const SizedBox(),
                      _productInventoryWidget(),
                      _productStatusWidget(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
        const SizedBox(height: 4 * kSpacing),
        Row(
          children: [
            Expanded(child: Container()),
            _indexWidget(),
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
            const Icon(
              Icons.qr_code_rounded,
            ),
            const SizedBox(width: kSpacing),
            Text(
              "${numberFormat.format(product.codesCount)}"
              " code${product.codesCount == 1 ? '' : 's'}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(child: Container()),
        productsMenu(product)
      ],
    );
  }

  Widget _productPhotoWidget(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: Responsiveness.isScreenSmall(context) ? 50 : 100,
        height: Responsiveness.isScreenSmall(context) ? 50 : 100,
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            product.title,
          ),
        ),
      ],
    );
  }

  Widget _productInventoryWidget() {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stackIcon(icon1: FontAwesomeIcons.boxes),
          const SizedBox(width: kSpacing),
          Text(
            "Inventory : ${numberFormat.format(product.inventoryQuantity)}",
          ),
        ],
      ),
    );
  }

  Widget _productTypeWidget() {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stackIcon(icon1: FontAwesomeIcons.solidFolder),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              product.type,
            ),
          ),
        ],
      ),
    );
  }

  Widget _vendorWidget() {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stackIcon(icon1: FontAwesomeIcons.store),
          const SizedBox(width: kSpacing),
          Flexible(
            child: Text(
              "Vendor : ${product.vendor}",
            ),
          ),
        ],
      ),
    );
  }

  Widget _productStatusWidget() {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Chip(
        backgroundColor: product.status.color(),
        label: Text(
          product.status.name(),
          style: TextStyle(
            color: product.status.onColor(),
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _indexWidget() {
    return Container(
      margin: const EdgeInsets.only(right: kSpacing * 2),
      child: Text(
        "${numberFormat.format(productIndex)} of ${numberFormat.format(productsCount)}",
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _stackIcon({
    required IconData icon1,
    IconData? icon2,
    Color? icon2Color,
  }) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(7),
          child: Center(
            child: Icon(
              icon1,
              size: 13,
            ),
          ),
        ),
        if (icon2 != null)
          Positioned(
            right: 0,
            child: Icon(
              icon2,
              color: icon2Color,
              size: 10,
            ),
          )
      ],
    );
  }
}
