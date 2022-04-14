import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/reports/widgets/report_tile.dart';

class ReportsTable extends StatelessWidget {
  const ReportsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final visibleCount = reportsController.visibleCount();
      final totalCount = reportsController.reportsCount();
      return Stack(
        children: [
          ListView.separated(
            separatorBuilder: (context, index) =>
                const Divider(thickness: 1, height: 1),
            itemCount: min(visibleCount + 1, totalCount),
            itemBuilder: (context, index) {
              if (index == visibleCount) {
                reportsController.showMore();
                return ListTile(
                  hoverColor: Colors.transparent,
                  dense: true,
                  contentPadding: const EdgeInsets.only(
                    top: 20,
                    left: kSpacing,
                    right: kSpacing,
                  ),
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
              final report = reportsController.report(index);
              return Column(
                children: [
                  ReportTile(
                    report: report,
                    index: index + 1,
                    totalCount: totalCount,
                    onSelected: (selectedGroup) {
                      //TODO codesController.open(selectedGroup.key);
                      reportsController.markAsRead(report);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      );
    });
  }
}
