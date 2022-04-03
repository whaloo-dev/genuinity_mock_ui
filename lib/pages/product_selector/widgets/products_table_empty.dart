import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/url_launcher.dart';

final controller = productSelectorController;

class ProductsTableEmptyWidget extends StatelessWidget {
  const ProductsTableEmptyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 100,
          child: Column(
            children: [
              const SizedBox(height: kSpacing * 4),
              controller.isLoadingData()
                  ? const Center(
                      child: Text("Loading..."),
                    )
                  : controller.isFiltered()
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
                              Stack(
                                children: const [
                                  Icon(
                                    Icons.shopify_rounded,
                                    size: 30,
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Icon(
                                      FontAwesomeIcons.exclamationCircle,
                                      size: 10,
                                      color: kWarningColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: kSpacing),
                              const Text("Products catalog is empty."),
                              const SizedBox(height: kSpacing * 3),
                              TextButton(
                                onPressed: () {
                                  goToShopify();
                                },
                                child: const Text("GO TO SHOPIFY"),
                              ),
                            ],
                          ),
                        ),
            ],
          ),
        ));
  }
}
