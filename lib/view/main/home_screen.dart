import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/view/component/products.dart';
import 'package:e_commerce/view/main/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/viewmodel/auth view model/auth_view_model.dart';
import '../component/categories.dart';
import '../component/search_bar.dart';
import 'detials_screen.dart';

class HomeScreen extends GetWidget<AuthViewModel> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              onSubmit: _submit,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CategoriesWidget(onTap: _gotoCategory),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: ListTile(
                title: Text(
                  'Best Selling',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _buildProductList()
          ],
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Products')
            .doc('Men')
            .collection('Product')
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ProductsWidget(
              onTap: _gotoDetailsScreen,
              snapshot: snapshot,
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return errorWidget();
          }
        }));
  }

  Widget errorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/server_down.svg',
            width: 20.w,
            height: 20.h,
          ),
          SizedBox(height: 5.h),
          Text(
            'Somthing want wrong',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _submit(value) {}

  void _gotoDetailsScreen(product) {
    Get.to(() => DetialsScreen(), arguments: product);
  }

  void _gotoCategory(categoryName) {
    Get.to(() => const CategoryScreen(), arguments: categoryName);
  }
}
