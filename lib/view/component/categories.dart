import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../model/category.dart';

class CategoriesWidget extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  final Function(Categories) onTap;
  const CategoriesWidget({
    super.key,
    required this.snapshot,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 15.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: snapshot.data!.docs.map((doc) {
          final Categories categories = Categories.fromMap(doc.data());
          return CategoryWidget(onTap: onTap, categories: categories);
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
      onTap: onTap(categories),
      child: Padding(
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
      ),
    );
  }
}
