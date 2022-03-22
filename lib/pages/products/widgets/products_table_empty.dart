import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class ProductsTableEmptyWidget extends StatelessWidget {
  const ProductsTableEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          child: SizedBox(
            height: 100,
            child: Column(
              children: [
                const SizedBox(height: kSpacing * 4),
                productsController.isLoadingData()
                    ? const Center(
                        child: Text("Loading..."),
                      )
                    : productsController.isFiltered()
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.warning_rounded),
                                SizedBox(height: kSpacing),
                                Text("No Results Found"),
                              ],
                            ),
                          )
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
                                const Text("There's no codes yet."),
                                const SizedBox(height: kSpacing * 3),
                                FloatingActionButton(
                                  child: const Icon(Icons.add),
                                  onPressed: () {
                                    newCodesController.open();
                                  },
                                ),
                              ],
                            ),
                          )
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Stack(
                //         children: const [
                //           Icon(
                //             Icons.shopify_rounded,
                //             size: 30,
                //           ),
                //           Positioned(
                //             right: 0,
                //             child: Icon(
                //               FontAwesomeIcons.exclamationCircle,
                //               size: 10,
                //               color: kWarningColor,
                //             ),
                //           ),
                //         ],
                //       ),
                //       const SizedBox(height: kSpacing),
                //       const Text("Products Catalog Is Empty."),
                //       const SizedBox(height: kSpacing * 3),
                //       ElevatedButton(
                //         onPressed: () {
                //           goToShopify();
                //         },
                //         child: const Text("Go To Shopify Admin"),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ));
  }
}
