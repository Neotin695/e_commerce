import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/product.dart';

enum ProductType {
  men,
  women,
  electronic,
  toy,
  kids,
  smartPhone,
  computer,
  homeAppliances,
  other
}

class AdminProductViewModel extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController count = TextEditingController();
  TextEditingController size = TextEditingController();

  final _storeRef = FirebaseFirestore.instance;
  final _storageRef = FirebaseStorage.instance.ref('Products/images');

  List<XFile> _images = [];
  List<File> imageFiles = [];
  final ImagePicker _imagePicker = ImagePicker();

  // Color pickerColor = Color(0xff443a49);
  List<Color> currentColor = [];

  List<Color> availableColors = [];
// ValueChanged<Color> callback
  void changeColor(colors) {
    availableColors.clear();
    availableColors.addAll(colors);
    update();
  }

  createProduct(categoryName) async {
    if (_images.isEmpty) {
      _showMessageToUser('Error', 'Please select images first');
    } else if (name.text.isEmpty) {
      _showMessageToUser('Error', 'Please enter product name first');
    } else if (price.text.isEmpty) {
      _showMessageToUser('Error', 'Please  enter product price first');
    } else if (desc.text.isEmpty) {
      _showMessageToUser('Error', 'Please  enter product description first');
    } else {
      final downloadingUrls = await _uploadImages();
      final product = Product(
          id: name.text,
          name: name.text,
          price: double.parse(price.text),
          disc: desc.text,
          imagesUrls: downloadingUrls,
          category: categoryName,
          count: int.parse(count.text),
          colors: List<int>.from(availableColors.map((e) => e.value)),
          sizes: size.text.split(','));
      _storeRef
          .collection('Products')
          .doc(product.category)
          .collection('Product')
          .doc(product.name)
          .set(product.toMap());
      _cleanAllInputs();
    }
    update();
  }

  void _cleanAllInputs() {
    name.clear();
    price.clear();
    desc.clear();
    imageFiles.clear();
    _images.clear();
  }

  Future<List<String>> _uploadImages() async {
    List<String> downloadingUrls = [];
    try {
      for (var imageFile in imageFiles) {
        final snapshot = await _storageRef
            .child(imageFile.path.split('/').last)
            .putFile(imageFile);
        _showUploadingStateToUser(snapshot);
        downloadingUrls.add(await snapshot.ref.getDownloadURL());
      }
      return downloadingUrls;
    } on FirebaseException {
      return [''];
    }
  }

  _showUploadingStateToUser(snapshot) {
    Get.snackbar('Uploading State',
        snapshot.state == TaskState.success ? "Successful" : 'Waiting',
        snackPosition: SnackPosition.BOTTOM);
  }

  getImages() async {
    _images.clear();
    _images = await _getSelectedImages();
    if (isImagesNotAvailable) {
      _showMessageToUser('User Event', 'user cancel selected');
    } else {
      imageFiles.addAll(_getImagesByPath(_images));
    }
    update();
  }

  void _showMessageToUser(title, message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  bool get isImagesNotAvailable => _images.isEmpty;

  _getImagesByPath(images) {
    return _images.map((xFile) => File(xFile.path));
  }

  _getSelectedImages() async {
    return await _imagePicker.pickMultiImage();
  }
}
