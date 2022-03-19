import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class CodesTableEmptyWidget extends StatelessWidget {
  const CodesTableEmptyWidget({Key? key}) : super(key: key);

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

                  //TODO result not found widget

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
                          ElevatedButton(
                            onPressed: () {
                              //TODO create code
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text("New Code"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ));
  }
}
