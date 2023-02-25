import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/viewmodel/home view model/bottom_navigation_view_model.dart';
import '../../component/err_widget.dart';
import '../admin_drawer.dart';

class CreateProduct extends GetWidget<BottomNavigationViewModel> {
  const CreateProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrWidget(
          title: 'No internet connection',
          imageUrl: 'assets/icons/server_down.svg',
          child:  GetBuilder<BottomNavigationViewModel>(
          init: BottomNavigationViewModel(),
          builder: (controller) => Scaffold(
                appBar: AppBar(),
                drawer: const AdminDrawer(),
                body: controller.currentPrductScreen,
                bottomNavigationBar: _buildBottomNavigationBar(controller),
              )),
    );
  }

  _buildBottomNavigationBar(controller) {
    return BottomNavigationBar(
      currentIndex: controller.currentIndex,
      onTap: controller.changeSelectedItem,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: '',
          activeIcon: Text('Procuts'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          label: '',
          activeIcon: Text('Modify'),
        ),
      ],
    );
  }
}
