import 'package:e_commerce/core/constance%20datat/category_data.dart';
import 'package:e_commerce/view/component/err_widget.dart';
import 'package:e_commerce/view/main/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/viewmodel/product view model/admin_product_view_model.dart';

class AdminProductListScreen extends GetWidget<AdminProductViewModel> {
  const AdminProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ErrWidget(
      title: 'No Internet connection!',
      imageUrl: 'assets/icons/server_down.svg',
      child: ListView(
        children: CategoryData.categories.map((category) {
          return Column(
            children: [
              ListTile(
                onTap: () => Get.to(() => const CategoryScreen(),
                    arguments: category.name),
                leading: SvgPicture.asset(
                  category.imageUrl,
                  width: 5.w,
                  height: 5.h,
                ),
                title: Text(category.name),
              ),
              const Divider()
            ],
          );
        }).toList(),
      ),
    ));
  }
}
