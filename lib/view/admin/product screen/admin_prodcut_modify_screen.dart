import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/view/component/color_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/constance datat/category_data.dart';
import '../../../core/viewmodel/product view model/admin_product_view_model.dart';
import '../../component/multi_color_picker.dart';

class AdminProductModifyScreen extends GetWidget<AdminProductViewModel> {
  const AdminProductModifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final space = SizedBox(height: 2.5.h);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          GetBuilder<AdminProductViewModel>(
            init: AdminProductViewModel(),
            builder: (controller) => InkWell(
              onTap: () {
                controller.getImages();
              },
              child: CarouselSlider(
                options: CarouselOptions(height: 30.h),
                items: controller.imageFiles.isEmpty
                    ? List.generate(
                        3,
                        (index) => const Icon(
                              Icons.add_a_photo,
                              size: 200,
                            ))
                    : controller.imageFiles
                        .map((file) => Image.file(file))
                        .toList(),
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
            child: ListView(
              children: CategoryData.categories.map((category) {
                return ExpansionTile(
                  title: Text(category.name),
                  children: [
                    space,
                    _buildPaddingTextField(controller.name, 'Product title'),
                    space,
                    _buildPaddingTextField(controller.price, 'Product price',
                        TextInputType.number),
                    space,
                    _buildPaddingTextField(
                        controller.desc, 'Product description'),
                    space,
                    _buildPaddingTextField(controller.count, 'Product count',
                        TextInputType.number),
                    space,
                    _buildPaddingTextField(controller.size, 'Product size',
                        TextInputType.text, 'xl,l,xlll'),
                    space,
                    _buildAvailableColorsWidget(category, context, space),
                    space,
                    ElevatedButton.icon(
                      onPressed: () {
                        controller.createProduct(category.name);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Create Product'),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildAvailableColorsWidget(category, context, space) {
    return GetBuilder<AdminProductViewModel>(
      init: AdminProductViewModel(),
      builder: (controllers) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          category.name != 'Toy' || category.name != 'Computer'
              ? _buildColorPickerWidget(context, space, controllers)
              : Container(),
          ColorsWidget(availableColors: controller.availableColors),
        ],
      ),
    );
  }

  Widget _buildColorPickerWidget(context, space, controllers) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return MultiColorPicker(controller: controllers, space: space);
          },
        );
      },
      child: const Text('Choice color'),
    );
  }

  Widget _buildPaddingTextField(cn, title, [type, hint]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: TextField(
        controller: cn,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: title,
          hintText: hint,
        ),
      ),
    );
  }
}
