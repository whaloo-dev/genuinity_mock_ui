import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models/global.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

final controller = filteringController;

class ReportsToolbar extends StatelessWidget {
  const ReportsToolbar({Key? key}) : super(key: key);

  static double fontSize = 12;

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
    return Obx(
      () {
        return Container(
          margin: const EdgeInsets.only(top: kSpacing),
          child: Row(
            children: [
              TextButton.icon(
                label: AnimatedSize(
                  duration: kAnimationDuration,
                  child: SizedBox(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        const SizedBox(width: kSpacing),
                        Chip(
                          label: _sortingOption(
                            controller.reportsSorting(),
                            isSelected: true,
                            showNameExtension: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                icon: const Icon(Icons.tune_rounded),
                onPressed: () {
                  controller.changeExpanded(!controller.expanded());
                },
              ),
              Expanded(
                child: Container(),
              ),
              _timeSpanWidget(),
            ],
          ),
        );
      },
    );
  }

  Widget _timeSpanWidget() {
    final selectedTimeSpan = controller.timeSpan();
    return DropdownButton<TimeSpan>(
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
                    fontWeight:
                        timeSpan == selectedTimeSpan ? FontWeight.bold : null,
                    color: menuController.theme().colorScheme.onBackground),
              ),
            ),
          )
          .toList(),
      onChanged: (newValue) {
        controller.changeTimeSpan(newValue!);
      },
    );
  }

  Widget _body() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(top: kSpacing),
        height: controller.expanded() ? 75 : 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //TODO _filterByCodeStatus(),
            _sortBy(),
            const SizedBox(width: kSpacing),
          ],
        ),
      ),
    );
  }

  Widget _sortBy() {
    return Obx(() {
      final selectedSorting = controller.reportsSorting();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("SORT BY",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
          const SizedBox(height: kSpacing),
          _sortingMenu(
              "Date", Sorting.dateAsc, Sorting.dateDesc, selectedSorting),
          // _sortingMenu(
          //     "Scans", Sorting.scansAsc, Sorting.scansDesc, selectedSorting),
          // _sortingMenu("Scan Errors", Sorting.scanErrorsAsc,
          //     Sorting.scanErrorsDesc, selectedSorting),
        ],
      );
    });
  }

  Widget _sortingMenu(
      String text, Sorting asc, Sorting desc, Sorting selected) {
    final value = selected == asc || selected == desc ? selected : null;
    return DropdownButton<Sorting>(
        onChanged: (sorting) {
          controller.changeReportsSorting(sorting ?? selected);
          Future.delayed(kAnimationDuration, () {
            controller.changeExpanded(false);
          });
        },
        borderRadius: kBorderRadius,
        icon: Container(),
        hint: Text(text),
        value: value,
        style: TextStyle(fontSize: fontSize),
        items: [asc, desc]
            .map(
              (sorting) => DropdownMenuItem<Sorting>(
                value: sorting,
                child: _sortingOption(sorting, isSelected: sorting == value),
              ),
            )
            .toList());
  }

  Widget _sortingOption(Sorting sorting,
      {required bool isSelected, bool showNameExtension = true}) {
    return Row(
      children: [
        Icon(
            sorting.isAsk()
                ? Icons.arrow_upward_rounded
                : Icons.arrow_downward_rounded,
            size: 14),
        const SizedBox(width: kSpacing),
        SizedBox(
          child: RichText(
            text: TextSpan(
              text: sorting.name(),
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: isSelected ? FontWeight.bold : null,
                color: menuController.theme().colorScheme.onBackground,
              ),
              children: [
                if (showNameExtension)
                  TextSpan(
                    text: " (${sorting.nameExtension()})",
                    style: TextStyle(
                      fontSize: 11,
                      color: menuController.theme().hintColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
