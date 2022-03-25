import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models.dart';

class StoreController extends GetxController {
  static StoreController get instance => Get.find();

  var isDataLoaded = false.obs;
  Store? store;

  @override
  void onReady() async {
    await loadDemoStoreData();
    super.onReady();
  }

  Future<void> loadDemoStoreData() async {
    var backend = Backend.instance;
    var future = backend.getCurrentStore();
    future.then((value) {
      store = value;
      isDataLoaded.value = true;
    });
  }
}
