import 'package:get/get.dart';

import '../viewmodel/auth view model/auth_view_model.dart';
import '../viewmodel/category view model/admin_category_view_model.dart';
import '../viewmodel/home view model/bottom_navigation_view_model.dart';
import '../viewmodel/home view model/hom_screen_view_model.dart';
import '../viewmodel/product view model/admin_product_view_model.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => HomeScreenViewModel());
    Get.lazyPut(() => AdminCategoryViewModel());
    Get.lazyPut(() => AdminProductViewModel());
    Get.lazyPut(() => BottomNavigationViewModel());
  }
}
