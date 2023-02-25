import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../main/main_home_screen.dart';
import 'category screen/admin_create_category_screen.dart';
import 'main_admin_screen.dart';
import 'message_screen.dart';
import 'product screen/admin_create_product_screen.dart';

enum SubmitType { category, product, message, home, store }

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            height: 20.h,
            width: double.infinity,
            child: Center(
              child: Text(
                'E-Commerce',
                style: TextStyle(
                  fontSize: 25.sp,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () => _submit(SubmitType.category),
            title: const Text('Add Category'),
            leading: const Icon(Icons.category),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => _submit(SubmitType.product),
            title: const Text('Add Product'),
            leading: const Icon(Icons.category_outlined),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => _submit(SubmitType.message),
            title: const Text('Messages'),
            leading: const Icon(Icons.message),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => _submit(SubmitType.home),
            title: const Text('Home screen'),
            leading: const Icon(Icons.home),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => _submit(SubmitType.store),
            title: const Text('Store'),
            leading: const Icon(Icons.store),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  void _submit(SubmitType submitType) {
    switch (submitType) {
      case SubmitType.category:
        Get.off(() => const CreateCategory());
        break;
      case SubmitType.product:
        Get.off(() => const CreateProduct());
        break;
      case SubmitType.message:
        Get.off(() => const MessageScreen());
        break;
      case SubmitType.home:
        Get.off(() => const MainAdminScreen());
        break;
      case SubmitType.store:
        Get.to(() => const MainHomeScreen());
        break;
    }
  }
}
