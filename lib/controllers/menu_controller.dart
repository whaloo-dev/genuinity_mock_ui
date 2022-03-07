import 'package:whaloo_genuinity/routes/routes.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  var activeItem = dashboardPageItem.obs;
  var hoverItem = nonePageItem.obs;

  changeActiveItemTo(MenuItem item) {
    activeItem.value = item;
  }

  onHover(MenuItem item) {
    if (!isActive(item)) {
      hoverItem.value = item;
    }
  }

  isActive(MenuItem item) => activeItem.value == item;

  isHovering(MenuItem item) => hoverItem.value == item;
}
