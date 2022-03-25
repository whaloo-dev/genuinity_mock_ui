import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';
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
      dense: true,
      hoverColor: Colors.transparent,
      leading: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Icon(
          Icons.add_circle_outlined,
          color: colorScheme.primary.withOpacity(0.4),
        ),
      ),
      title: _productTileBody(context),
      contentPadding: const EdgeInsets.symmetric(horizontal: kSpacing),
      subtitle: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: kSpacing,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // TODO show elements focused on code : number of qrcodes, last updated date, number of scans ..etc
          _qrCodesWidget(),

          Row(
            children: [
              Expanded(child: Container()),
              _indexWidget(),
            ],
          ),
        ],
      ),
      onTap: () {
        onSelected(product);
      },
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
            Expanded(child: _productTitleWidget()),
            productsMenu(product),
          ],
        ),
      ],
    );
  }

  Widget _qrCodesWidget() {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stackIcon(icon1: Icons.qr_code_rounded),
          Text(
            "${numberFormat.format(product.codesCount)}"
            " code${product.codesCount == 1 ? '' : 's'}",
          ),
        ],
      ),
    );
  }

  Widget _productPhotoWidget(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width:
            Responsiveness.isScreenSmall(context) ? kSmallImage : kLargeImage,
        height:
            Responsiveness.isScreenSmall(context) ? kSmallImage : kLargeImage,
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

  Widget _indexWidget() {
    return Container(
      margin: const EdgeInsets.only(top: kSpacing, right: kSpacing * 2),
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