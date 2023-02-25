import 'package:flutter/material.dart';

import 'admin_drawer.dart';

class MainAdminScreen extends StatelessWidget {
  const MainAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      drawer: const AdminDrawer(),
      body: Column(
        children: const [Text('Home')],
      ),
    );
  }
}
