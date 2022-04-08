import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models/code.dart';
import 'package:whaloo_genuinity/pages/detail/detail.dart';

class CodeDetailController extends GetxController {
  static CodeDetailController instance = Get.find();

  final _code = Rx<Code?>(null);

  Code? code() => _code.value;

  open(Code code) {
    Get.closeAllSnackbars();
    _code.value = code;
    Get.dialog(
      const DetailDialog(),
    );
  }

  close() {
    Get.back();
  }
}
