import 'package:whaloo_genuinity/controllers/code_detail_controller.dart';
import 'package:whaloo_genuinity/controllers/codes_controller.dart';
import 'package:whaloo_genuinity/controllers/codes_filtering_controller.dart';
import 'package:whaloo_genuinity/controllers/groups_controller.dart';
import 'package:whaloo_genuinity/controllers/menu_controller.dart';
import 'package:whaloo_genuinity/controllers/navigation_controller.dart';
import 'package:whaloo_genuinity/controllers/codes_creation_controller.dart';
import 'package:whaloo_genuinity/controllers/products_selector_controller.dart';
import 'package:whaloo_genuinity/controllers/store_controller.dart';

MenuController menuController = MenuController.instance;
NavigationController navigationController = NavigationController.instance;
StoreController storeController = StoreController.instance;
GroupsController groupsController = GroupsController.instance;
CodesFilteringController codesFilteringController =
    CodesFilteringController.instance;
ProductsSelectorController productSelectorController =
    ProductsSelectorController.instance;
CodesController codesController = CodesController.instance;
CodesCreationController codesCreationController =
    CodesCreationController.instance;
CodeDetailController codeDetailController = CodeDetailController.instance;
