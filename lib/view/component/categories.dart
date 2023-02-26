import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/constance datat/category_data.dart';
import '../../model/category.dart';

class CategoriesWidget extends StatelessWidget {
  final Function(String) onTap;
  const CategoriesWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 15.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: CategoryData.categories.map((category) {
          return InkWell(
            onTap: () => onTap(category.name),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                children: [
                  SvgPicture.asset(
                    category.imageUrl,
                    width: 10.w,
                    height: 10.h,
                  ),
                  Text(
                    category.name,
                  ),
                  const Divider()
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.onTap,
    required this.categories,
  });

  final Function(Categories p1) onTap;
  final Categories categories;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(categories),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          children: [
            SvgPicture.asset(
              categories.imageUrl,
              width: 7.w,
              height: 7.h,
            ),
            Text(
              categories.name,
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
