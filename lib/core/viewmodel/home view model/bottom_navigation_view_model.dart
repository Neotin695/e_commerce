import 'package:get/get.dart';

import '../../../view/admin/category screen/admin_category_list_scree.dart';
import '../../../view/admin/category screen/admin_modify_category_screen.dart';
import '../../../view/admin/product screen/admin_prodcut_modify_screen.dart';
import '../../../view/admin/product screen/admin_product_list_screen.dart';
import '../../../view/main/cart_screen.dart';
import '../../../view/main/home_screen.dart';
import '../../../view/main/profile_screen.dart';

enum SelectedMainScreen { homescreen, cartscreen, profilescreen }

enum SelectedCategoryScreen { categorylist, modifycategory }

enum SelectedProductScreen { productlist, productmodify }

class BottomNavigationViewModel extends GetxController {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  SelectedCategoryScreen get _currentSelectedCategoryScreen {
    switch (_currentIndex) {
      case 0:
        return SelectedCategoryScreen.categorylist;
      case 1:
        return SelectedCategoryScreen.modifycategory;
      default:
        return SelectedCategoryScreen.categorylist;
    }
  }

  get currentCategoryScreen {
    switch (_currentSelectedCategoryScreen) {
      case SelectedCategoryScreen.modifycategory:
        return const AdminModifyCategoryScreen();
      case SelectedCategoryScreen.categorylist:
        return const AdminCateogyListScreen();
    }
  }

// main screen bottom navigation bar
  SelectedMainScreen get _currentSelectedMainScreen {
    switch (_currentIndex) {
      case 0:
        return SelectedMainScreen.homescreen;
      case 1:
        return SelectedMainScreen.cartscreen;
      case 2:
        return SelectedMainScreen.profilescreen;
      default:
        return SelectedMainScreen.homescreen;
    }
  }

  get currentMainScreen {
    switch (_currentSelectedMainScreen) {
      case SelectedMainScreen.homescreen:
        return HomeScreen();
      case SelectedMainScreen.cartscreen:
        return const CartScreen();
      case SelectedMainScreen.profilescreen:
        return const ProfileScreen();
    }
  }

  SelectedProductScreen get _currentSelectedProductScreen {
    switch (_currentIndex) {
      case 0:
        return SelectedProductScreen.productlist;
      case 1:
        return SelectedProductScreen.productmodify;
      default:
        return SelectedProductScreen.productlist;
    }
  }

  get currentPrductScreen {
    switch (_currentSelectedProductScreen) {
      case SelectedProductScreen.productlist:
        return const AdminProductListScreen();
      case SelectedProductScreen.productmodify:
        return const AdminProductModifyScreen();
    }
  }

  changeSelectedItem(int index) {
    _currentIndex = index;
    update();
  }
}
