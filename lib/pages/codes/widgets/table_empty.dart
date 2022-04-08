import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models/product.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class CodesTableEmptyWidget extends StatelessWidget {
  final Product product;
  const CodesTableEmptyWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 100,
          child: Column(
            children: [
              const SizedBox(height: kSpacing * 4),
              codesController.isLoadingData()
                  ? const Center(
                      child: Text("Loading..."),
                    )

                  //TODO Codes:  result not found widget

                  // : productsController.isFiltered()
                  //     ? Center(
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: const [
                  //             Icon(Icons.warning_rounded),
                  //             SizedBox(height: kSpacing),
                  //             Text("No Results Found"),
                  //           ],
                  //         ),
                  //       )

                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          const Icon(
                            Icons.qr_code_2_rounded,
                            size: 30,
                          ),
                          const SizedBox(height: kSpacing),
                          const Text("There's no codes for this product."),
                          const SizedBox(height: kSpacing * 3),
                          FloatingActionButton(
                            heroTag: null,
                            child: const Icon(Icons.add),
                            onPressed: () {
                              creationController.createNew(product: product);
                            },
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ));
  }
}
