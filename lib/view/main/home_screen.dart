import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../model/category.dart';
import '../../core/viewmodel/auth view model/auth_view_model.dart';
import '../../model/product.dart';
import 'detials_screen.dart';

class HomeScreen extends GetWidget<AuthViewModel> {
  HomeScreen({super.key});
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      debounceDuration: const Duration(milliseconds: 10),
      connectivityBuilder: (_, result, child) {
        if (result == ConnectivityResult.none) {
          return Scaffold(
            body: Center(
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
                    'No Internet Connection',
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        }
        return child;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
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
              _buildCategoryList(),
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
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
      ),
      child: AnimSearchBar(
        width: 100.w,
        textController: _searchController,
        onSuffixTap: () {
          _searchController.clear();
        },
        onSubmitted: _submit,
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
            return SizedBox(
                width: double.infinity,
                height: 40.h,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data!.docs.map((doc) {
                      Product product = Product.fromMap(doc.data());
                      return InkWell(
                        onTap: () => _gotoDetailsScreen(product),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  product.imagesUrls.first,
                                  fit: BoxFit.cover,
                                  height: 28.h,
                                ),
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 30.w,
                                  child: Text(
                                    product.disc.substring(0, 15),
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${product.price}\$',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                              ],
                            )),
                      );
                    }).toList()));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
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
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }
        }));
  }

  Widget _buildCategoryList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              width: double.infinity,
              height: 15.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: snapshot.data!.docs.map((doc) {
                  final Categories categories = Categories.fromMap(doc.data());
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: [
                        SvgPicture.network(
                          categories.imageUrl,
                          width: 10.w,
                          height: 10.h,
                        ),
                        Text(
                          categories.name,
                        ),
                        const Divider()
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _submit(value) {}

  void _gotoDetailsScreen(product) {
    Get.to(() => DetialsScreen(), arguments: product);
  }
}
