import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/viewmodel/home view model/bottom_navigation_view_model.dart';
import '../../../core/viewmodel/home view model/hom_screen_view_model.dart';

class MainHomeScreen extends GetWidget<HomeScreenViewModel> {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationViewModel>(
      init: BottomNavigationViewModel(),
      builder: (controllers) => Scaffold(
        appBar: AppBar(title: const Text('E-commerce')),
        body: controllers.currentMainScreen,
        bottomNavigationBar: _buildNavigationBar(),
      ),
    );
  }

  Widget _buildNavigationBar() {
    return GetBuilder<BottomNavigationViewModel>(
      init: BottomNavigationViewModel(),
      builder: (value) => BottomNavigationBar(
        currentIndex: value.currentIndex,
        onTap: value.changeSelectedItem,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            activeIcon: Text(
              'Explorer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            activeIcon: Text(
              'Cart',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            activeIcon: Text(
              'Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
