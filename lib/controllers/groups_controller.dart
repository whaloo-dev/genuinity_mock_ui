import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models/code.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';

class GroupsController extends GetxController {
  static GroupsController instance = Get.find();

  static const int _loadingStep = 10;
  final _isLoadingData = true.obs;
  final _groups = <Group>[].obs;
  final _visibleCount = 0.obs;

  @override
  void onReady() {
    super.onReady();
    Backend.instance.addListener(BackendEvent.groupUpdated, ({arguments}) {
      load(showDataLoading: false);
    });
    filteringController.addFilteringListener(() {
      load();
    });
  }

  void load({bool showDataLoading = true}) {
    _load(refresh: showDataLoading);
  }

  Future<void> showMore() async {
    return Future.delayed(const Duration(milliseconds: 1), () {
      _visibleCount.value =
          min(_visibleCount.value + _loadingStep, groupsCount());
    });
  }

  Group group(int index) {
    return _groups[index];
  }

  int visibleCount() {
    return _visibleCount.value;
  }

  int groupsCount() {
    return _groups.length;
  }

  bool isDataLoading() {
    return _isLoadingData.value;
  }

  Future<void> _load({required bool refresh}) async {
    if (refresh) {
      _isLoadingData.value = true;
    }
    Backend.instance.loadGroups(sorting: filteringController.sorting()).then(
      (groups) {
        _groups.value = groups;
        if (refresh) {
          _visibleCount.value = min(_loadingStep, groupsCount());
          _isLoadingData.value = false;
        } else {
          _visibleCount.value = min(_visibleCount.value, groupsCount());
        }
      },
    );
  }
}
