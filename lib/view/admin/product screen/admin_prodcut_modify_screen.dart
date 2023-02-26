import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/constance datat/category_data.dart';
import '../../../core/viewmodel/product view model/admin_product_view_model.dart';

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
            space,
            _buildPaddingTextField(controller.name, 'Product name'),
            space,
            _buildPaddingTextField(
                controller.price, 'Product price', TextInputType.number),
            space,
            _buildPaddingTextField(controller.desc, 'Product description'),
            space,
            CustomDropMenuItem(onChange: (data) {
              controller.category = data.toString();
            }),
            space,
            ElevatedButton.icon(
              onPressed: () {
                controller.createProduct();
              },
              icon: const Icon(Icons.add),
              label: const Text('Create Product'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaddingTextField(cn, title, [type]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: TextField(
        controller: cn,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: title,
        ),
      ),
    );
  }
}

class CustomDropMenuItem extends StatelessWidget {
  final Function(String?) onChange;
  const CustomDropMenuItem({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: CategoryData.categories.map((category) {
        return DropdownMenuItem(
          value: category.name,
          child: Text(category.name),
        );
      }).toList(),
      onChanged: onChange,
    );
  }
}
