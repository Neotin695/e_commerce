import 'package:flutter/material.dart';

import '../component/err_widget.dart';
import 'admin_drawer.dart';

class MainAdminScreen extends StatelessWidget {
  const MainAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrWidget(
      title: 'No internet connection',
      imageUrl: 'assets/icons/server_down.svg',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin'),
        ),
        drawer: const AdminDrawer(),
        body: Column(
          children: const [Text('Home')],
        ),
      ),
    );
  }
}
