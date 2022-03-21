import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/codes_table.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/codes_header.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/codes_table_empty.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

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
            child: Stack(children: [
              Card(
                child: Column(
                  children: [
                    CodesHeader(product: product),
                    (codesController.codesCount() == 0 ||
                            codesController.isLoadingData())
                        ? Expanded(
                            child: CodesTableEmptyWidget(product: product))
                        : Expanded(child: CodesTable(product: product)),
                  ],
                ),
              ),
              if (codesController.codesCount() != 0)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(kSpacing),
                      child: FloatingActionButton(
                        child: const Icon(Icons.add),
                        onPressed: () {
                          navigationController.navigateTo(newCodesPageRoute,
                              arguments: product);
                        },
                      ),
                    ),
                  ),
                )
            ]),
          ),
          const SizedBox(height: kSpacing),
        ],
      ),
    );
  }
}
