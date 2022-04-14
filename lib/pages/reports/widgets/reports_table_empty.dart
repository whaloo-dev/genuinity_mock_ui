import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class ReportsTableEmptyWidget extends StatelessWidget {
  const ReportsTableEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 100,
        child: Column(
          children: [
            const SizedBox(height: kSpacing * 4),
            reportsController.isLoadingData()
                ? const Center(
                    child: Text("Loading..."),
                  )
                :
                // TODO add report filtering
                // productsController.isFiltered()
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
                //     :
                Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(height: 50),
                        Icon(
                          Icons.qr_code_2_rounded,
                          size: 30,
                        ),
                        SizedBox(height: kSpacing),
                        Text("There's no reports yet."),
                        SizedBox(height: kSpacing * 3),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
