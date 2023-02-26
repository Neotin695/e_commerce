import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/view/component/err_widget.dart';
import 'package:e_commerce/view/component/products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'detials_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryName = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: ErrWidget(
        title: 'No internet connection!',
        imageUrl: 'assets/icons/server_down.svg',
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Products')
              .doc(categoryName)
              .collection("Product")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 5,
                 ),
                children: snapshot.data!.docs.map((data) {
                  final Product product = Product.fromMap(data.data());
                  return ProductWidget(
                    onTap: _gotoDetailsScreen,
                    product: product,
                  );
                }).toList(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _gotoDetailsScreen(product) {
    Get.to(() => DetialsScreen(), arguments: product);
  }
}
