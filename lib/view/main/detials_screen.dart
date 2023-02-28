import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../model/product.dart';
import '../component/color_widget.dart';
import '../component/err_widget.dart';

class DetialsScreen extends StatelessWidget {
  DetialsScreen({super.key});

  final Product product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return ErrWidget(
      title: 'No internet connection',
      imageUrl: 'assets/icons/server_down.svg',
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSlider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildOption(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                child: Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                child: Text(
                  product.disc,
                ),
              ),
              _buildBottomAction(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Card(
              elevation: 3,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                height: 10.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'PRICE',
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                        Text(
                          "\$${product.price}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('ADD'),
                      ),
                    )
                  ],
                ),
              ),
            );
  }

  Row _buildOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DropdownButton(
            items: product.sizes.map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                ),
              );
            }).toList(),
            onChanged: (v) {}),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Colour:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
            ),
            SizedBox(width: 1.w),
            ColorsWidget(
              availableColors:
                  List<Color>.from(product.colors.map((e) => Color(e))),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildImageSlider() {
    return CarouselSlider(
      items: product.imagesUrls
          .map((imageUrl) => Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ))
          .toList(),
      options: CarouselOptions(height: 53.h),
    );
  }
}
