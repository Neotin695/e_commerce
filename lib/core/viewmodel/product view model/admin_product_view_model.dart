import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/product.dart';

class AdminProductViewModel extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController count = TextEditingController();
  TextEditingController size = TextEditingController();

  final GlobalKey<FormState> globalKey = GlobalKey();

  final _storeRef = FirebaseFirestore.instance.collection('Products');
  final _storageRef = FirebaseStorage.instance.ref('Products/images');

  List<Color> currentColor = [];
  List<Color> availableColors = [];
  void changeColor(colors) {
    availableColors.clear();
    availableColors.addAll(colors);
    update();
  }

  String? customValidator(String? value) {
    if (value!.isEmpty) {
      return 'this field is required';
    } else {
      return null;
    }
  }

  createProductByCategoryName(categoryName) async {
    if (imagesEmpty) {
      _showMessageToUser('Error', 'Please select images first');
    } else if (inputsNotValidate) {
      return;
    } else {
      final downloadUrls = await _uploadImages();
      final pathFireStore =
          _storeRef.doc(categoryName).collection('Product').doc();
      final product =
          initDataToModel(categoryName, downloadUrls, pathFireStore.id);
      pathFireStore.set(product.toMap());
      _cleanAllInputs();
    }
    update();
  }

  bool get inputsNotValidate => !globalKey.currentState!.validate();

  bool get imagesEmpty => _images.isEmpty;

  Product initDataToModel(categoryName, downloadUrls, id) {
    return Product(
        id: id,
        name: name.text,
        price: double.parse(price.text),
        disc: desc.text,
        imagesUrls: downloadUrls,
        category: categoryName,
        count: int.parse(count.text),
        colors: List<int>.from(availableColors.map((e) => e.value)),
        sizes: size.text.split(','));
  }

  void _cleanAllInputs() {
    name.clear();
    price.clear();
    desc.clear();
    imageFiles.clear();
    _images.clear();
    count.clear();
    size.clear();
    availableColors.clear();
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

  _showMessageToUser(title, message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> _images = [];
  List<File> imageFiles = [];
  bool get isImagesNotAvailable => _images.isEmpty;

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

  _getImagesByPath(images) {
    return _images.map((xFile) => File(xFile.path));
  }

  _getSelectedImages() async {
    return await _imagePicker.pickMultiImage();
  }
}
