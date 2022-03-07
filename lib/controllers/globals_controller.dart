import 'package:get/get.dart';

class GlobalsController extends GetxController implements DisposableInterface {
  static GlobalsController instance = Get.find();

  var appName = "Genuinity";
  var appVersion = "2.2";
  var appRelease = "Adam";
}
