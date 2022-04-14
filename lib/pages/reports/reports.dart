import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/pages/reports/widgets/reports_table.dart';
import 'package:whaloo_genuinity/pages/reports/widgets/reports_table_empty.dart';
import 'package:whaloo_genuinity/pages/reports/widgets/reports_toolbar.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const ReportsToolbar(),
          Expanded(
            child: Card(
              child: Column(
                children: [
                  (reportsController.reportsCount() == 0 ||
                          reportsController.isLoadingData())
                      ? const Expanded(child: ReportsTableEmptyWidget())
                      : const Expanded(child: ReportsTable()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
