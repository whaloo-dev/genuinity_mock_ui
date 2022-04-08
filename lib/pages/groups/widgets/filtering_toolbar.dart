import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models/code.dart';
import 'package:whaloo_genuinity/backend/models/global.dart';
import 'package:whaloo_genuinity/backend/models/product.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/product_selector/product_selector_dialog.dart';

final controller = codesFilteringController;

class FilteringToolbar extends StatelessWidget {
  final Product? product;
  const FilteringToolbar({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(children: [
        _header(),
        AnimatedSize(
          duration: kAnimationDuration,
          child: _body(),
        ),
      ]),
    );
  }

  Widget _header() {
    double fontSize = 12;

    return Obx(
      () {
        final selectedTimeSpan = controller.timeSpan();
        return Row(
          children: [
            TextButton.icon(
              label: AnimatedSize(
                duration: kAnimationDuration,
                child: SizedBox(
                    width: controller.expanded() ? null : 0,
                    child: controller.expanded()
                        ? const Text(
                            "FILTERS",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : null),
              ),
              icon: const Icon(Icons.tune_rounded),
              onPressed: () {
                controller.changeExpanded(!controller.expanded());
              },
            ),
            Expanded(child: Container()),
            DropdownButton<TimeSpan>(
              isDense: true,
              borderRadius: kBorderRadius,
              value: selectedTimeSpan,
              style: TextStyle(fontSize: fontSize),
              items: TimeSpan.values
                  .map(
                    (timeSpan) => DropdownMenuItem(
                      value: timeSpan,
                      child: Text(
                        timeSpan.name(),
                        style: TextStyle(
                            fontWeight: timeSpan == selectedTimeSpan
                                ? FontWeight.bold
                                : null,
                            color: Get.theme.colorScheme.onBackground),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (newValue) {
                controller.changeTimeSpan(newValue!);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _body() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(top: kSpacing),
        height: controller.expanded() ? 200 : 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (product == null) _selectedProduct(),
            if (product != null) _filterByCodeStatus(),
            //TODO if (product != null) _filterByVariant(),
            _sortBy(),
            const SizedBox(width: kSpacing),
          ],
        ),
      ),
    );
  }

  Widget _selectedProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("PRODCUT",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
        const SizedBox(height: kSpacing),
        TextButton.icon(
          icon: const Icon(Icons.search_rounded),
          label: const Text("SEARCH", style: TextStyle(fontSize: 11)),
          onPressed: () {
            Get.dialog(ProductSelectorDialog(onSelected: (product) {
              codesController.open(product);
            }));
          },
        )
      ],
    );
  }

  Widget _filterByCodeStatus() {
    return Obx(() {
      CodeStatus? codeStatus = controller.codeStatus();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("STATUS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
          const SizedBox(height: kSpacing),
          ...CodeStatus.values
              .map(
                (status) =>
                    _statusWidget(status, selected: codeStatus == status),
              )
              .toList()
        ],
      );
    });
  }

  Widget _statusWidget(CodeStatus status, {required bool selected}) {
    return Container(
      padding: const EdgeInsets.only(top: kSpacing),
      // width: 100,
      child: InputChip(
        isEnabled: true,
        selected: selected,
        selectedColor: status.color(),
        backgroundColor: status.color(),
        checkmarkColor: status.onColor(),
        onPressed: () {
          controller.changeCodeStatus(selected ? null : status);
          Future.delayed(kAnimationDuration, () {
            controller.changeExpanded(false);
          });
        },
        label: SizedBox(
          width: 50,
          child: Text(
            status.name(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: status.onColor(),
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  // Widget _filterByVariant() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text("VARIANT",
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
  //       const SizedBox(height: kSpacing),
  //       Obx(
  //         () => DropdownButton<ProductVariant>(
  //           isDense: true,
  //           borderRadius: kBorderRadius,
  //           value: controller.variant() != null &&
  //                   controller.variant()!.product == product
  //               ? controller.variant()
  //               : null,
  //           style: const TextStyle(fontSize: 12),
  //           onChanged: (newValue) {
  //             controller.changeVariant(newValue!);
  //             Future.delayed(kAnimationDuration, () {
  //               controller.changeExpanded(false);
  //             });
  //           },
  //           items: product!.variants
  //               .map(
  //                 (variant) => DropdownMenuItem(
  //                   value: variant,
  //                   child: Row(
  //                     children: [
  //                       const SizedBox(width: kSpacing),
  //                       ConstrainedBox(
  //                         constraints: const BoxConstraints(maxWidth: 150),
  //                         child: RichText(
  //                           text: TextSpan(
  //                             text: variant.title,
  //                             style: TextStyle(
  //                               fontSize: 11,
  //                               fontWeight: variant == controller.variant()
  //                                   ? FontWeight.bold
  //                                   : null,
  //                               color: Get.theme.colorScheme.onBackground,
  //                             ),
  //                             children: [
  //                               TextSpan(
  //                                 text: "\nSKU : ${variant.sku}",
  //                                 style: TextStyle(
  //                                   color: Get.theme.hintColor,
  //                                   fontSize: 11,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               )
  //               .toList(),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _sortBy() {
    return Obx(() {
      final selectedSorting = controller.sorting();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("SORT BY",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
          const SizedBox(height: kSpacing),
          _sortingOption(
              "Date", Sorting.dateAsc, Sorting.dateDesc, selectedSorting),
          _sortingOption(
              "Scans", Sorting.scansAsc, Sorting.scansDesc, selectedSorting),
          _sortingOption("Scan Errors", Sorting.scanErrorsAsc,
              Sorting.scanErrorsDesc, selectedSorting),
        ],
      );
    });
  }

  Widget _sortingOption(
      String text, Sorting asc, Sorting desc, Sorting selected) {
    final value = selected == asc || selected == desc ? selected : null;
    return DropdownButton<Sorting>(
        onChanged: (sorting) {
          controller.changeSorting(sorting ?? selected);
          Future.delayed(kAnimationDuration, () {
            controller.changeExpanded(false);
          });
        },
        borderRadius: kBorderRadius,
        icon: Container(),
        hint: Text(text),
        value: value,
        style: const TextStyle(fontSize: 12),
        items: [asc, desc].map((sorting) {
          return DropdownMenuItem(
            value: sorting,
            child: Row(
              children: [
                Icon(
                    sorting == asc
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    size: 14),
                const SizedBox(width: kSpacing),
                SizedBox(
                  width: 120,
                  child: RichText(
                    text: TextSpan(
                      text: sorting.name(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: value != sorting ? null : FontWeight.bold,
                        color: Get.theme.colorScheme.onBackground,
                      ),
                      children: [
                        TextSpan(
                          text: " (${sorting.nameExtension()})",
                          style: TextStyle(
                            fontSize: 11,
                            color: Get.theme.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList());
  }
}
