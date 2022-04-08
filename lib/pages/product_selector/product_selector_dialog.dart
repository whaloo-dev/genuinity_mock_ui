import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/pages/product_selector/product_selector.dart';

class ProductSelectorDialog extends StatelessWidget {
  final void Function(Product selectedProduct) onSelected;
  const ProductSelectorDialog({Key? key, required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dialogLayout(
      Card(
        child: Column(
          children: [
            _headerWidget(),
            Expanded(
              child: ProductsSelector(
                onSelected: (product) {
                  onSelected(product);
                  Get.back();
                },
                onCancel: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: kSpacing),
          child: Text("SELECT A PRODUCT : "),
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: IconButton(
            splashRadius: kSplashRadius,
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              Get.back();
            },
          ),
        )
      ],
    );
  }
}
