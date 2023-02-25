import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/viewmodel/auth view model/auth_view_model.dart';

class ProfileScreen extends GetWidget<AuthViewModel> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ElevatedButton.icon(
          label: const Text("LogOut"),
          onPressed: () => controller.signOut(),
          icon: const Icon(Icons.logout),
        ),
      ),
    );
  }
}
