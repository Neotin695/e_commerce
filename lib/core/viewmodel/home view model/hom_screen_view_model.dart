import 'package:get/get.dart';

import '../../../view/main/cart_screen.dart';
import '../../../view/main/home_screen.dart';
import '../../../view/main/profile_screen.dart';

enum SelectedScreen { homescreen, cartscreen, profilescreen }

class HomeScreenViewModel extends GetxController {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  SelectedScreen get _currentSelectedScreen {
    switch (_currentIndex) {
      case 0:
        return SelectedScreen.homescreen;
      case 1:
        return SelectedScreen.cartscreen;
      case 2:
        return SelectedScreen.profilescreen;
      default:
        return SelectedScreen.homescreen;
    }
  }

  get currentScreen {
    switch (_currentSelectedScreen) {
      case SelectedScreen.homescreen:
        return const HomeScreen();
      case SelectedScreen.cartscreen:
        return const CartScreen();
      case SelectedScreen.profilescreen:
        return const ProfileScreen();
    }
  }

  changeSelectedItem(int index) {
    _currentIndex = index;
    update();
  }
}
