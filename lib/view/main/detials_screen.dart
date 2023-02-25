import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../model/product.dart';

class DetialsScreen extends StatelessWidget {
  DetialsScreen({super.key});

  final Product product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CarouselSlider(
            items: product.imagesUrls
                .map((imageUrl) => Image.network(imageUrl))
                .toList(),
            options: CarouselOptions(height: 30.h),
          ),
          Text(
            product.name,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
