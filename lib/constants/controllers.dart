import 'package:whaloo_genuinity/controllers/code_detail_controller.dart';
import 'package:whaloo_genuinity/controllers/codes_controller.dart';
import 'package:whaloo_genuinity/controllers/menu_controller.dart';
import 'package:whaloo_genuinity/controllers/navigation_controller.dart';
import 'package:whaloo_genuinity/controllers/codes_creation_controller.dart';
import 'package:whaloo_genuinity/controllers/products_controller.dart';
import 'package:whaloo_genuinity/controllers/store_controller.dart';

MenuController menuController = MenuController.instance;
NavigationController navigationController = NavigationController.instance;
StoreController storeController = StoreController.instance;
ProductsController productsController = ProductsController.instance;
ProductsController productSelectorController =
    ProductsController(showProductsHavingCodesOnly: false);
CodesController codesController = CodesController.instance;
CodesCreationController codesCreationController =
    CodesCreationController.instance;
CodeDetailController codeDetailController = CodeDetailController.instance;
