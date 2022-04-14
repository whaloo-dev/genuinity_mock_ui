import 'dart:math';

import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models/code.dart';
import 'package:whaloo_genuinity/backend/models/reports.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

class ReportsController extends GetxController {
  static ReportsController instance = Get.find();

  static int loadingSteps = 10;

  final _isLoadingData = true.obs;

  final _reports = <Report>[].obs;
  final _visibleCount = 0.obs;

  _callback({arguments}) {
    loadReports();
  }

  @override
  void onReady() {
    super.onReady();
    Backend.instance.addListener(BackendEvent.reportsUpdated, _callback);
    filteringController.addFilteringListener(_callback);
  }

  Future<void> loadReports() async {
    _isLoadingData.value = true;
    Future.delayed(Duration.zero, () {
      Backend.instance
          .loadReports(
        timeSpan: filteringController.timeSpan(),
        reportsSorting: filteringController.reportsSorting(),
      )
          .then((reports) {
        _reports.value = reports;
        _visibleCount.value = min(loadingSteps, _reports.length);
        _isLoadingData.value = false;
      });
    });
  }

  Future<void> showMore() async {
    Future.delayed(Duration.zero, () {
      _visibleCount.value =
          min(_visibleCount.value + loadingSteps, _reports.length);
    });
  }

  void markAsRead(Report report) {
    report.isRead = true;
    _reports[_reports.indexOf(report)] = report;
  }

  Report report(int index) => _reports[index];
  int visibleCount() => _visibleCount.value;
  int reportsCount() => _reports.length;
  bool isLoadingData() => _isLoadingData.value;

  open() {
    loadReports();
    navigationController.navigateTo(reportsPageRoute);
  }
}
