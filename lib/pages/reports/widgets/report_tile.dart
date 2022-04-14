import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models/reports.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';

class ReportTile extends StatelessWidget {
  final Report report;
  final int index;
  final int totalCount;
  final void Function(Report report) onSelected;

  const ReportTile({
    Key? key,
    required this.onSelected,
    required this.report,
    required this.index,
    required this.totalCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      hoverColor: Colors.transparent,
      title: _tileBody(),
      contentPadding: const EdgeInsets.symmetric(horizontal: kSpacing),
      onTap: () {
        onSelected(report);
      },
    );
  }

  Widget _tileBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: kSpacing),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: kSpacing),
                    width: 150,
                    child: Text(
                      report.reporter.name,
                      style: TextStyle(
                          fontWeight: report.isRead ? null : FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: kSpacing),
                    width: 150,
                    child: Text(
                      report.reporter.email,
                      style: TextStyle(
                          fontWeight: report.isRead ? null : FontWeight.bold),
                    ),
                  ),
                  Text(
                    report.message,
                    style: TextStyle(
                        fontWeight: report.isRead ? null : FontWeight.bold),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                dynamicDateTimeFormat(report.timestamp),
                style: TextStyle(
                    fontWeight: report.isRead ? null : FontWeight.bold),
              ),
            )
          ],
        ),
        const SizedBox(height: kSpacing),
        Row(
          children: [
            Expanded(child: Container()),
            Obx(
              () => Text(
                "$index/$totalCount",
                style: TextStyle(
                  color: menuController.theme().hintColor,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(width: kSpacing),
          ],
        ),
        const SizedBox(height: kSpacing),
      ],
    );
  }
}
