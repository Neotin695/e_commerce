import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/viewmodel/category view model/admin_category_view_model.dart';
import '../../../model/category.dart';

class AdminCateogyListScreen extends GetWidget<AdminCategoryViewModel> {
  const AdminCateogyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                final Categories categories = Categories.fromMap(doc.data());
                return Column(
                  children: [
                    ListTile(
                      leading: SvgPicture.network(
                        categories.imageUrl,
                        width: 10.w,
                        height: 10.h,
                      ),
                      title: Text(
                        categories.name,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      trailing: PopupMenuButton(
                        onSelected: (selectedItem) =>
                            _selectedItem(selectedItem, categories),
                        itemBuilder: (_) {
                          return const [
                            PopupMenuItem(
                              value: SelectedItem.edit,
                              child: Text('Edit'),
                            ),
                            PopupMenuItem(
                              value: SelectedItem.delete,
                              child: Text('Delete'),
                            ),
                          ];
                        },
                      ),
                    ),
                    const Divider()
                  ],
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _selectedItem(SelectedItem value, data) {
    switch (value) {
      case SelectedItem.edit:
        // TODO: Handle this case.
        break;
      case SelectedItem.delete:
        controller.deleteCategory(data);
        break;
    }
  }
}
