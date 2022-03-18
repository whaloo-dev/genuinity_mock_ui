import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/pages/codes/widgets/code_tile.dart';

class CodesTable extends StatelessWidget {
  final Product product;
  const CodesTable({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final visibleCodesCount = codesController.visibleCodesCount();
      final codesCount = product.codesCount; //codesController.codesCount();
      return ListView.separated(
        separatorBuilder: (context, index) =>
            const Divider(thickness: 1, height: 1),
        itemCount: codesCount, //min(visibleCodesCount + 1, codesCount),
        itemBuilder: (context, index) {
          // print("$index $visibleCodesCount");
          // if (index == visibleCodesCount) {
          //   codesController.showMore();
          //   return ListTile(
          //     hoverColor: Colors.transparent,
          //     dense: true,
          //     title: Center(
          //       child: Container(
          //         padding: const EdgeInsets.all(kSpacing),
          //         child: Container(
          //           padding: const EdgeInsets.all(kSpacing),
          //           child: const Text("Loading..."),
          //         ),
          //       ),
          //     ),
          //   );
          // }
          Code code = codesController.code(product, index);
          return CodeTile(
            code: code,
            index: index + 1,
            totalCount: product.codesCount,
          );
        },
      );
    });
  }
}
