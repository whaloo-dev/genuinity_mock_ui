import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models/code.dart';
import 'package:whaloo_genuinity/backend/models/global.dart';
import 'package:whaloo_genuinity/backend/models/product.dart';

class FilteringController extends GetxController {
  static FilteringController instance = Get.find();

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

  void addFilteringListener(void Function() callback) {
    _sorting.listen((value) {
      callback();
    });
    _timeSpan.listen((value) {
      callback();
    });
    _codeStatus.listen((value) {
      callback();
    });
  }

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