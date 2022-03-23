import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/header.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/table.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/table_empty.dart';

class CodesPage extends StatelessWidget {
  final Product product;
  const CodesPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    codesController.loadCodes(product);
    return Obx(
      () => Column(
        children: [
          Expanded(
            child: Card(
              child: Column(
                children: [
                  CodesHeader(product: product),
                  (codesController.codesCount() == 0 ||
                          codesController.isLoadingData())
                      ? Expanded(child: CodesTableEmptyWidget(product: product))
                      : Expanded(child: CodesTable(product: product)),
                ],
              ),
            ),
          ),
          const SizedBox(height: kSpacing),
        ],
      ),
    );
  }
}
