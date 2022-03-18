import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/codes_table.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/codes_header.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/codes_table_empty.dart';

class CodesPage extends StatelessWidget {
  final Product product;
  const CodesPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    codesController.loadCodes(product);
    return Card(
      child: Obx(
        () => Column(
          children: [
            CodesHeader(product: product),
            (codesController.codesCount() == 0 ||
                    codesController.isLoadingData())
                ? const Expanded(child: CodesTableEmptyWidget())
                : Expanded(
                    child: CodesTable(
                      product: product,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
