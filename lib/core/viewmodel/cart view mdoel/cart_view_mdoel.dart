import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CartViewModel extends GetxController {
  final collection = FirebaseFirestore.instance.collection('Carts');
  
}
