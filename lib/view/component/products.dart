import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/product.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductsWidget extends StatelessWidget {
  final Function(Product) onTap;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  const ProductsWidget(
      {super.key, required this.onTap, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: snapshot.data!.docs.map((doc) {
          Product product = Product.fromMap(doc.data());
          return ProductWidget(onTap: onTap, product: product);
        }).toList(),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.onTap,
    required this.product,
  });

  final Function(Product p1) onTap;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(product),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.imagesUrls.first,
                fit: BoxFit.cover,
                height: 28.h,
              ),
              Text(
                product.name.substring(0, 8),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 30.w,
                child: Text(
                  product.disc.substring(0, 10),
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
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          )),
    );
  }
}
