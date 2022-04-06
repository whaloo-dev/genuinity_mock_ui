import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';

class CodesFilteringController extends GetxController {
  static CodesFilteringController instance = Get.find();

  final _timeSpan = TimeSpan.sevenDays.obs;

  TimeSpan timeSpan() => _timeSpan.value;

  void changeTimeSpan(TimeSpan newValue) {
    _timeSpan.value = newValue;
  }
}
