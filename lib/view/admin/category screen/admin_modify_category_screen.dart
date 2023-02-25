import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../model/category.dart';
import '../../../core/viewmodel/category view model/admin_category_view_model.dart';

class AdminModifyCategoryScreen extends GetWidget<AdminCategoryViewModel> {
  const AdminModifyCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextField(
            controller: controller.categoryName,
            decoration: const InputDecoration(labelText: 'Category name'),
          ),
        ),
        SizedBox(height: 3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              label: const Text('Select File'),
              onPressed: () {
                controller.selectFile();
              },
              icon: const Icon(Icons.file_open),
            ),
            ElevatedButton.icon(
              label: const Text('Create Category'),
              onPressed: () async {
                controller.createCategory(Categories(
                    id: controller.categoryName.text,
                    name: controller.categoryName.text,
                    imageUrl: ''));
              },
              icon: const Icon(Icons.create),
            ),
          ],
        ),
      ],
    );
  }
}
