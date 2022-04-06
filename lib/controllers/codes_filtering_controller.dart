import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';

class CodesFilteringController extends GetxController {
  static CodesFilteringController instance = Get.find();

  final _expanded = false.obs;
  final _timeSpan = TimeSpan.sevenDays.obs;
  final _codeStatus = Rx<CodeStatus?>(null);
  final _sorting = Sorting.dateDesc.obs;
  final _variant = Rx<ProductVariant?>(null);

  TimeSpan timeSpan() => _timeSpan.value;
  CodeStatus? codeStatus() => _codeStatus.value;
  Sorting sorting() => _sorting.value;
  bool expanded() => _expanded.value;
  ProductVariant? variant() => _variant.value;

  void changeTimeSpan(TimeSpan newValue) {
    _timeSpan.value = newValue;
  }

  void changeCodeStatus(CodeStatus? newValue) {
    _codeStatus.value = newValue;
  }

  void changeSorting(Sorting newValue) {
    _sorting.value = newValue;
  }

  void changeExpanded(bool newValue) {
    _expanded.value = newValue;
  }

  void changeVariant(ProductVariant? variant) {
    _variant.value = variant;
  }

  void reset() {
    _expanded.value = false;
  }
}
