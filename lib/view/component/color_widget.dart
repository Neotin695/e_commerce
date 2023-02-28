import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ColorsWidget extends StatelessWidget {
  final List<Color> availableColors;
  const ColorsWidget({super.key, required this.availableColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      width: 50.w,
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.3.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color.fromARGB(255, 201, 200, 200)),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: availableColors.map((e) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Container(
              width: 8.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: e,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
