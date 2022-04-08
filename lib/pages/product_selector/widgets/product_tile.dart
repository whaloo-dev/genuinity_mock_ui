import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whaloo_genuinity/backend/models/product.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';
import 'package:whaloo_genuinity/widgets/photo_widget.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final int productIndex;
  final int productsCount;
  final int vendorsCount;
  final int productTypesCount;
  final bool showMenu;
  final bool showFooter;
  final void Function(Product product) onSelected;

  const ProductTile({
    Key? key,
    required this.onSelected,
    required this.product,
    required this.productIndex,
    required this.productsCount,
    required this.vendorsCount,
    required this.productTypesCount,
    this.showMenu = true,
    this.showFooter = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: Colors.transparent,
      dense: true,
      title: _productTileBody(),
      onTap: () {
        onSelected(product);
      },
    );
  }

  Widget _productTileBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: kSpacing * 2),
        Row(
          children: [
            photoWidget(product.image),
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
        if (showFooter)
          Row(
            children: [
              Expanded(child: Container()),
              _indexWidget(),
            ],
          ),
      ],
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
      margin: const EdgeInsets.only(top: 10, right: 10),
      child: Text(
        "${numberFormat.format(productIndex)} of ${numberFormat.format(productsCount)}",
        style: const TextStyle(
          // color: kDarkColor,
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
