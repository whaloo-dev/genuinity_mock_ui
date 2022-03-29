import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/tile.dart';

class CodesTable extends StatelessWidget {
  final Product product;
  const CodesTable({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          final visibleCodesCount = codesController.visibleCodesCount();
          final codesCount = codesController.codesCount();
          return ListView.separated(
            separatorBuilder: (context, index) =>
                const Divider(thickness: 1, height: 1),
            itemCount: min(visibleCodesCount + 1, codesCount),
            itemBuilder: (context, index) {
              if (index == visibleCodesCount) {
                codesController.showMore();
                return ListTile(
                  hoverColor: Colors.transparent,
                  dense: true,
                  title: Center(
                    child: Container(
                      padding: const EdgeInsets.all(kSpacing),
                      child: Container(
                        padding: const EdgeInsets.all(kSpacing),
                        child: const Text("Loading..."),
                      ),
                    ),
                  ),
                );
              }
              Code code = codesController.code(product, index);
              return Column(
                children: [
                  CodeTile(
                    code: code,
                    index: index + 1,
                    totalCount: product.codesCount,
                  ),
                  //added space for the floating action button
                  if (index + 1 == product.codesCount)
                    const SizedBox(height: kSpacing * 11),
                ],
              );
            },
          );
        }),
        if (codesController.codesCount() != 0)
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.all(kSpacing * 3),
                child: FloatingActionButton(
                  heroTag: null,
                  child: const Icon(Icons.add),
                  onPressed: () {
                    codesCreationController.open(product: product);
                  },
                ),
              ),
            ),
          )
      ],
    );
  }
}
