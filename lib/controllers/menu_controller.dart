import 'package:whaloo_genuinity/routes/routes.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  var activeItem = productsPageItem.obs;
  var hoverItem = nonePageItem.obs;

  changeActiveItemTo(MainMenuItem item) {
    activeItem.value = item;
  }

  onHover(MainMenuItem item) {
    if (!isActive(item)) {
      hoverItem.value = item;
    }
  }

  isActive(MainMenuItem item) => activeItem.value == item;

  isHovering(MainMenuItem item) => hoverItem.value == item;
}
