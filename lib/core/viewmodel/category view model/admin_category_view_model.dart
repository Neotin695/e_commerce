import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../model/category.dart';

enum SelectedItem { edit, delete }

class AdminCategoryViewModel extends GetxController {
  final CollectionReference _categoryRef =
      FirebaseFirestore.instance.collection('Categories');

  TextEditingController categoryName = TextEditingController();

  final _storageRef = FirebaseStorage.instance.ref('Categories/images');

  PlatformFile file = PlatformFile(name: '', size: 0);

  createCategory(Categories categories) async {
    if (file.name == '') {
      _showMessageToUser('Error', 'Please select file first');
      return;
    } else {
      if (categoryName.text.isEmpty) {
        _showMessageToUser('Error', 'Please Enter category name first');
        return;
      } else {
        final downloadUrl = await uploadFile();
        categories.imageUrl = downloadUrl;
        _saveCategoryToFirestore(categories);
      }
    }
    categoryName.clear();
    update();
  }

  deleteCategory(Categories categories) async {
    final result = await _deletefile(categories.imageUrl);
    _categoryRef.doc(categories.id).delete().then((value) =>
        _showMessageToUser('User Event', 'cateogry delete successfully'));
  }

  _deletefile(url) async {
    return await FirebaseStorage.instance.refFromURL(url).delete();
  }

  void _saveCategoryToFirestore(Categories categories) {
    _categoryRef.doc(categories.id).set(categories.toMap()).timeout(
        const Duration(seconds: 5),
        onTimeout: () => _showMessageToUser('Error', 'somthing want wrong!'));
  }

  Future<String> uploadFile() async {
    try {
      final snapshot =
          await _storageRef.child(file.name).putFile(File(file.path ?? ''));
      _showUploadingStateToUser(snapshot);
      return await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e);
      return '';
    }
  }

  _showUploadingStateToUser(snapshot) {
    Get.snackbar('Uploading State',
        snapshot.state == TaskState.success ? "Successful" : 'Waiting',
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> selectFile() async {
    final result = await _getSelectedFile();

    if (result != null) {
      file = result.files.first;
    } else {
      _showMessageToUser('User Event', 'User cancel selected file');
    }
  }

  void _showMessageToUser(title, message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  Future<FilePickerResult?> _getSelectedFile() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['svg'],
    );
  }
}
