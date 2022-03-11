import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/url_launcher.dart';

class ProductsTableEmptyWidget extends StatelessWidget {
  const ProductsTableEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          child: SizedBox(
            height: 100,
            child: Column(
              children: [
                SizedBox(height: kSpacing * 4),
                productsController.isLoadingData.value
                    ? const Center(
                        child: Text("Loading..."),
                      )
                    : productsController.isFiltered()
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.warning_rounded),
                                SizedBox(height: kSpacing),
                                const Text("No Results Found"),
                              ],
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: const [
                                    Icon(
                                      Icons.shopify_rounded,
                                      size: 30,
                                    ),
                                    Text(
                                      "!",
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: kSpacing),
                                const Text("Products Catalog Is Empty."),
                                SizedBox(height: kSpacing),
                                SizedBox(height: kSpacing),
                                SizedBox(height: kSpacing),
                                ElevatedButton(
                                  onPressed: () {
                                    launchURL(
                                        "https://${storeController.store!.name}.myshopify.com/");
                                  },
                                  child: const Text("Go To Shopify Admin"),
                                ),
                              ],
                            ),
                          )
              ],
            ),
          ),
        ));
  }
}
