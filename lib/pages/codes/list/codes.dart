import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/pages/codes/list/widgets/header.dart';
import 'package:whaloo_genuinity/pages/codes/list/widgets/table.dart';
import 'package:whaloo_genuinity/pages/codes/list/widgets/table_empty.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/codes_filtering_toolbar.dart';

class CodesPage extends StatelessWidget {
  const CodesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = codesController.product()!;
    return Obx(
      () => Column(
        children: [
          CodesToolbar(product: product),
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
        ],
      ),
    );
  }
}
