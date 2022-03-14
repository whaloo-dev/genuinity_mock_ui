import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';

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

class Store {
  String id;
  String name;
  String? imageUrl;
  String website;
  Store({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.website,
  }) : super();
}
