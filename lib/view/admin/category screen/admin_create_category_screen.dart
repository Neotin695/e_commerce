import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/viewmodel/home view model/bottom_navigation_view_model.dart';
import '../admin_drawer.dart';

class CreateCategory extends GetWidget<BottomNavigationViewModel> {
  const CreateCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationViewModel>(
      init: BottomNavigationViewModel(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Category Managament'),
        ),
        drawer: const AdminDrawer(),
        body: controller.currentCategoryScreen,
        bottomNavigationBar: _buildNavigationBar(),
      ),
    );
  }

  Widget _buildNavigationBar() {
    return GetBuilder<BottomNavigationViewModel>(
      init: BottomNavigationViewModel(),
      builder: (controller) => BottomNavigationBar(
        currentIndex: controller.currentIndex,
        onTap: controller.changeSelectedItem,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              activeIcon: Text('Categories'),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.create), activeIcon: Text('Modify'), label: '')
        ],
      ),
    );
  }
}
