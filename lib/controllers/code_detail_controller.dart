import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/pages/code_detail/code_detail.dart';

class CodeDetailController extends GetxController {
  static CodeDetailController instance = Get.find();

  final _code = Rx<Code?>(null);

  Code? code() => _code.value;

  open(Code code) {
    _code.value = code;
    Get.dialog(
      const CodeDetail(),
    );
  }

  cancel() {
    Get.back();
  }
}
