import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';
import 'package:whaloo_genuinity/widgets/photo_widget.dart';

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
      title: _productTileBody(),
      contentPadding: const EdgeInsets.symmetric(horizontal: kSpacing),
      onTap: () {
        onSelected(product);
      },
    );
  }

  Widget _productTileBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: kSpacing),
        Row(
          children: [
            photoWidget(product.image),
            const SizedBox(width: kSpacing),
            Expanded(child: _productTitleWidget()),
            Card(
              margin: const EdgeInsets.only(right: kSpacing * 2),
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.arrow_circle_left_rounded,
                color: colorScheme.primary.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _qrCodesWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _stackIcon(icon1: Icons.qr_code_rounded),
        Text(
          "${numberFormat.format(product.codesCount)}"
          " code${product.codesCount == 1 ? '' : 's'}",
        ),
      ],
    );
  }

  Widget _productTitleWidget() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                product.title,
              ),
            ),
          ],
        ),
        _qrCodesWidget(),
      ],
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
              size: 18,
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
