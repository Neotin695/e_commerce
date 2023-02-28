import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../../core/viewmodel/product view model/admin_product_view_model.dart';

class MultiColorPicker extends StatelessWidget {
  const MultiColorPicker({
    super.key,
    required this.controller,
    required this.space,
  });

  final AdminProductViewModel controller;
  final SizedBox space;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MultipleChoiceBlockPicker(
              pickerColors: controller.currentColor,
              onColorsChanged: controller.changeColor,
            ),
            space,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text('cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text('confirm'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
